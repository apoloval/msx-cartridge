#define PIN_CLOCK         2
#define PIN_ADDR_LATCH    3
#define PIN_ADDR_OUT      4
#define PIN_DATA_LATCH    5
#define PIN_DATA_READ     6
#define PIN_DATA_IN       7
#define PIN_DATA_OUT      8
#define PIN_WE            9
#define PIN_OE            10
#define PIN_ADDR16        11
#define PIN_ADDR17        12
#define PIN_ADDR18        13

#define SECTOR_SIZE       4096

#define COMMAND_READ      0
#define COMMAND_ERASE     1
#define COMMAND_WRITE     2
#define COMMAND_ERASEALL  3

#define SERIAL_BAUDRATE 921600

/** Put the given address in the bus through shift out registers. */
void put_addr(unsigned long addr) {
  digitalWrite(PIN_ADDR_LATCH, LOW);
  digitalWrite(PIN_CLOCK, LOW);
  shiftOut(PIN_ADDR_OUT, PIN_CLOCK, MSBFIRST, (byte) (addr >> 8));
  shiftOut(PIN_ADDR_OUT, PIN_CLOCK, MSBFIRST, (byte) addr);
  digitalWrite(PIN_ADDR16, bitRead(addr, 16));
  digitalWrite(PIN_ADDR17, bitRead(addr, 17));
  digitalWrite(PIN_ADDR18, bitRead(addr, 18));
  digitalWrite(PIN_ADDR_LATCH, HIGH);
}

/** Put the given data in the bus through shift out registers. */
void put_data(byte data) {
  digitalWrite(PIN_DATA_LATCH, LOW);
  digitalWrite(PIN_CLOCK, LOW);
  shiftOut(PIN_DATA_OUT, PIN_CLOCK, MSBFIRST, (byte) data);
  digitalWrite(PIN_DATA_LATCH, HIGH);
}

/** Get data from the data bus. */
byte get_data() {
  digitalWrite(PIN_OE, LOW);
  digitalWrite(PIN_CLOCK, HIGH);
  digitalWrite(PIN_DATA_LATCH, HIGH);
  digitalWrite(PIN_DATA_LATCH, LOW);
  digitalWrite(PIN_OE, HIGH);
  return shiftIn(PIN_DATA_IN, PIN_CLOCK, MSBFIRST);
}

/** Send a command to the ROM device. */
void send_cmd_seq(unsigned long* addr, byte* data, unsigned len) {
  digitalWrite(PIN_DATA_READ, LOW);
  digitalWrite(PIN_OE, HIGH);
  for (int i = 0; i < len; i++) {
    put_addr(addr[i]);
    digitalWrite(PIN_WE, LOW);
    put_data(data[i]);
    digitalWrite(PIN_WE, HIGH);
  }
  digitalWrite(PIN_DATA_READ, HIGH);
}

/** Read the content of given ROM device address. */
byte read_addr(unsigned long addr) {
  put_addr(addr);
  return get_data();
}

/** Wait for write/erase operation using data polling method. */
void wait_datapolling(byte data) {
  for (;;) {
    byte recv = get_data();
    if ((recv & 0x80) == (data & 0x80))
      return;
  }
}

/**
 * Write the content of the given ROM device address
 * with the given byte.
 */
void write_addr(unsigned long addr, byte data) {
  unsigned long addr_seq[] = { 0x5555, 0x2aaa, 0x5555, addr };
  byte data_seq[] = { 0xaa, 0x55, 0xa0, data };
  send_cmd_seq(addr_seq, data_seq, 4);
  wait_datapolling(data);
}

/**
 * Perform a blank test, returning the number of bytes that
 * are not equal to 0xff.
 */
int blank_test(byte sector) {
  unsigned long sector_addr = ((unsigned long) sector) << 12;
  int result = 0;
  for (int i = 0; i < SECTOR_SIZE; i++) {
    unsigned long addr = sector_addr + i;
    byte actual = read_addr(addr);
    if (actual != 0xff) {
      result++;
    }
  }
  return result;
}

/** Erase the whole memory. */
int erase_all() {
  unsigned long addr_seq[] = { 0x5555, 0x2aaa, 0x5555, 0x5555, 0x2aaa, 0x5555 };
  byte data_seq[] = { 0xaa, 0x55, 0x80, 0xaa, 0x55, 0x10 };
  send_cmd_seq(addr_seq, data_seq, 6);
  delay(500);
  return blank_test(0);
}

/** Erase the given sector. */
int erase_sector(byte sector) {
  unsigned long sector_addr = ((unsigned long) sector) << 12;
  unsigned long addr_seq[] = { 0x5555, 0x2aaa, 0x5555, 0x5555, 0x2aaa, sector_addr };
  byte data_seq[] = { 0xaa, 0x55, 0x80, 0xaa, 0x55, 0x30 };
  send_cmd_seq(addr_seq, data_seq, 6);
  delay(20);
  return blank_test(sector);
}

/** Read a single byte from serial, waiting if none has arrived yet. */
byte serial_read_byte() {
  while (Serial.available() < 1) {}
  return Serial.read();
}

/** Process a incoming read command from serial. */
void process_read_command() {
  unsigned long sector_addr = ((unsigned long) serial_read_byte()) << 12;
  for (int i = 0; i < SECTOR_SIZE; i++) {
    unsigned long addr = sector_addr + i;
    byte data = read_addr(addr);
    Serial.write(data);
  }
}

/** Process a incoming erase command from serial. */
void process_erase_command() {
  byte sector = serial_read_byte();
  Serial.write(erase_sector(sector));
}

/** Process a incoming erase command from serial. */
void process_eraseall_command() {
  Serial.write(erase_all());
}

/** Process a incoming write command from serial. */
void process_write_command() {
  unsigned long sector_addr = ((unsigned long) serial_read_byte()) << 12;
  for (int i = 0; i < SECTOR_SIZE; i++) {
    unsigned long addr = sector_addr + i;
    byte data = serial_read_byte();
    write_addr(addr, data);
    Serial.write(data);
  }
}

/** Process a incoming command from serial. */
void process_command() {
  switch (serial_read_byte()) {
    case COMMAND_READ:
      process_read_command();
      break;
    case COMMAND_ERASE:
      process_erase_command();
      break;
    case COMMAND_WRITE:
      process_write_command();
      break;
    case COMMAND_ERASEALL:
      process_eraseall_command();
      break;
  }
}

void setup() {
  pinMode(PIN_CLOCK, OUTPUT);
  pinMode(PIN_ADDR_LATCH, OUTPUT);
  pinMode(PIN_ADDR_OUT, OUTPUT);
  pinMode(PIN_DATA_LATCH, OUTPUT);
  pinMode(PIN_DATA_READ, OUTPUT);
  pinMode(PIN_DATA_IN, INPUT);
  pinMode(PIN_DATA_OUT, OUTPUT);
  pinMode(PIN_WE, OUTPUT);
  pinMode(PIN_OE, OUTPUT);
  pinMode(PIN_ADDR16, OUTPUT);
  pinMode(PIN_ADDR17, OUTPUT);
  pinMode(PIN_ADDR18, OUTPUT);

  digitalWrite(PIN_ADDR_LATCH, LOW);
  digitalWrite(PIN_DATA_LATCH, LOW);
  digitalWrite(PIN_DATA_READ, HIGH);
  digitalWrite(PIN_WE, HIGH);
  digitalWrite(PIN_OE, HIGH);
  delay(100);

  Serial.begin(SERIAL_BAUDRATE);
  Serial.write("ROM-BURNER");
}

void loop() {
  process_command();
}
