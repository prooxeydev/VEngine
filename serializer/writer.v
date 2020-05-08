module serializer

struct Writer {
mut:
	buf []byte
}

pub fn create_writer() &Writer {
	return &Writer{buf: []byte{}}
}

pub fn (writer mut Writer) write_i16(i i16) {
	mut v := i
	writer.buf << byte(v >> 8)
	writer.buf << byte(v)
}

pub fn (writer mut Writer) write_i32(i int) {
	mut v := i
	writer.buf << byte(v>>24)
	writer.buf << byte(v>>16)
	writer.buf << byte(v>>8)
	writer.buf << byte(v)
}

pub fn (writer mut Writer) write_i64(i i64) {
	mut v := i
	writer.buf << byte(v>>56)
	writer.buf << byte(v>>48)
	writer.buf << byte(v>>40)
	writer.buf << byte(v>>32)
	writer.buf << byte(v>>24)
	writer.buf << byte(v>>16)
	writer.buf << byte(v>>8)
	writer.buf << byte(v)
}

pub fn (writer mut Writer) write_u8(ui byte) {
	writer.buf << ui
}

pub fn (writer mut Writer) write_u16(ui u16) {
	mut v := ui
	writer.buf << byte(v >> 8)
	writer.buf << byte(v)
}

pub fn (writer mut Writer) write_u32(ui u32) {
	mut v := ui
	writer.buf << byte(v>>24)
	writer.buf << byte(v>>16)
	writer.buf << byte(v>>8)
	writer.buf << byte(v)
}

pub fn (writer mut Writer) write_u64(ui u64) {
	mut v := ui
	writer.buf << byte(v>>56)
	writer.buf << byte(v>>48)
	writer.buf << byte(v>>40)
	writer.buf << byte(v>>32)
	writer.buf << byte(v>>24)
	writer.buf << byte(v>>16)
	writer.buf << byte(v>>8)
	writer.buf << byte(v)
}

pub fn (writer mut Writer) write_i16_array(a []i16) {
	writer.write_i32(a.len)
	for i in a {
		writer.write_i16(i)
	}
}

pub fn (writer mut Writer) write_i32_array(a []int) {
	writer.write_i32(a.len)
	for i in a {
		writer.write_i32(i)
	}
}

pub fn (writer mut Writer) write_i64_array(a []i64) {
	writer.write_i32(a.len)
	for i in a {
		writer.write_i64(i)
	}
}

pub fn (writer mut Writer) write_u8_array(a []byte) {
	writer.write_u8(a.len)
	writer.buf << a
}

pub fn (writer mut Writer) write_u16_array(a []u16) {
	writer.write_i32(a.len)
	for i in a {
		writer.write_u16(i)
	}
}

pub fn (writer mut Writer) write_u32_array(a []u32) {
	writer.write_i32(a.len)
	for i in a {
		writer.write_u32(i)
	}
}

pub fn (writer mut Writer) write_u64_array(a []u64) {
	writer.write_i32(a.len)
	for i in a {
		writer.write_u64(i)
	}
}

pub fn (writer mut Writer) write_string(str string) {
	writer.write_i32(str.bytes().len)
	writer.buf << str.bytes()
}

pub fn (writer mut Writer) write_bool(b bool) {
	if b {
		writer.write_u8(0x01)
	} else {
		writer.write_u8(0x00)
	}
}