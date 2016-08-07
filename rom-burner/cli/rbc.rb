#!/usr/bin/env ruby
require "serialport"

MAX_SECTORS = 32

def read_handshake(serial)
  print "\tReceiving handshake from device... "
  handshake = serial.read(10)
  if handshake != "ROM-BURNER"
    raise IOError, "device responds with a invalid handshake in bytes '#{handshake}'"
  else
    print "Done\n"
  end
end

def read_sector(serial, sector)
  cmd = [0, sector].pack("CC")
  serial.write(cmd)
  serial.read(4096)
end

def erase_sector(serial, sector)
  cmd = [1, sector].pack("CC")
  serial.write(cmd)
  serial.read(1).unpack("C")[0]
end

def write_sector(serial, sector, data)
  cmd = [2, sector].pack("CC")
  serial.write(cmd)
  data.split("").each do |b|
    serial.write(b)
    sent = b.unpack("C")[0]
    recv = serial.read(1).unpack("C")[0]
    if sent != recv
      abort "ERROR\nByte 0x%x was sent, but device reported 0x%x" % [sent, recv]
    end
  end
end

def dump_rom(output_file, sectors)
  print "Getting ROM image from device... \n"
  SerialPort.open("COM3", 9600) { |serial|
    read_handshake(serial)
    File.open(output_file, "wb") { |file|
      for sector in sectors
        sector_addr = sector << 12
        print "\tReading sector at address 0x%.4x... " % sector_addr
        sector = read_sector(serial, sector)
        print "Done\n"
        file.write(sector)
      end
    }
  }
end

def erase_sectors(sectors)
  print "Erasing ROM sectors from device... \n"
  SerialPort.open("COM3", 9600) { |serial|
    read_handshake(serial)
    for sector in sectors
      sector_addr = sector << 12
      print "\tErasing sector at address 0x%.4x... " % sector_addr
      errors = erase_sector(serial, sector)
      if errors == 0
        print "Done\n"
      else
        print "Error (#{errors} bytes failed)\n"
      end
    end
  }
end

def burn_rom(input_file, initial_sector)
  print "Burning ROM image to device... \n"
  SerialPort.open("COM3", 9600) { |serial|
    read_handshake(serial)
    File.open(input_file, "rb") { |file|
      sector = initial_sector
      until file.eof?
        sector_addr = sector << 12
        print "\tWriting sector at address 0x%.4x... " % sector_addr
        data = file.read(4096)
        if data.length < 4096
          print "(too small sector, padding with zeroes) "
          data = data.ljust(4096, "\x00")
        end
        write_sector(serial, sector, data)
        print "Done\n"
        sector += 1
      end
    }
  }
end

def report_error(error)
  abort "Error: #{error}\n" +
    "Usage: rbc dump <output file> [<initial sector>] [<sector count>]\n" +
    "       rbc erase [<initial sector>] [<sector count>]\n" +
    "       rbc burn <input file> [<initial sector>]\n"
end

def get_arg(i)
  ARGV[i].nil? ? report_error("invalid arguments") : ARGV[i]
end

def get_arg_opt(i, default)
  ARGV[i].nil? ? default : ARGV[i]
end

def get_arg_in_range(i, range, default)
  val = get_arg_opt(i, default).to_i
  range.include?(val) ? val : report_error("value #{val} is out of range")
end

action = get_arg(0)

if action == 'dump'
  output_file = get_arg(1)
  initial_sector = get_arg_in_range(2, 0..MAX_SECTORS - 1, 0)
  left = MAX_SECTORS - initial_sector
  sector_count = get_arg_in_range(3, 1..left, left)
  dump_rom(output_file, initial_sector..(initial_sector + sector_count - 1))
elsif action == 'erase'
  initial_sector = get_arg_in_range(1, 0..MAX_SECTORS - 1, 0)
  left = MAX_SECTORS - initial_sector
  sector_count = get_arg_in_range(2, 1..left, left)
  erase_sectors(initial_sector..(initial_sector + sector_count - 1))
elsif action == 'burn'
  input_file = get_arg(1)
  initial_sector = get_arg_in_range(2, 0..MAX_SECTORS - 1, 0)
  burn_rom(input_file, initial_sector)
else
  abort "Error: unknown action '#{action}'"
end
