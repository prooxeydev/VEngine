module serializer

import encoding.binary

pub struct Reader {
	buf []byte
mut:
	offset u32
}

pub fn create_reader(buf []byte) &Reader {
	return &Reader{
		buf: buf
		offset: 0
	}
}

fn (reader mut Reader) read(len int) []byte {
	mut data := []byte{}
	for i := 0; i < len; i++ {
		data << reader.read_u8()
	}
	return data
}

pub fn (reader mut Reader) read_i16() i16 {
	return i16(reader.read_u16())
}

pub fn (reader mut Reader) read_i32() int {
	return int(reader.read_u32())
}

pub fn (reader mut Reader) read_i64() i64 {
	return i64(reader.read_u64())
}

pub fn (reader mut Reader) read_u8() byte {
	b := reader.buf[reader.offset]
	reader.offset += 1
	return b
}

pub fn (reader mut Reader) read_u16() u16 {
	return binary.big_endian_u16(reader.read(2))
}

pub fn (reader mut Reader) read_u32() u32 {
	return binary.big_endian_u32(reader.read(4))
}

pub fn (reader mut Reader) read_u64() u64 {
	return binary.big_endian_u64(reader.read(8))
}

pub fn (reader mut Reader) read_i16_array() []i16 {
	len := reader.read_i32()
	mut a := []i16{}
	for i := 0; i < len; i++ {
		a << reader.read_i16()
	}
	return a
}

pub fn (reader mut Reader) read_i32_array() []int {
	len := reader.read_i32()
	mut a := []int{}
	for i := 0; i < len; i++ {
		a << reader.read_i32()
	}
	return a
}

pub fn (reader mut Reader) read_i64_array() []i64 {
	len := reader.read_i32()
	mut a := []i64{}
	for i := 0; i < len; i++ {
		a << reader.read_i64()
	}
	return a
}

pub fn (reader mut Reader) read_u8_array() []byte {
	len := reader.read_i32()
	return reader.read(len)
}

pub fn (reader mut Reader) read_u16_array() []u16 {
	len := reader.read_i32()
	mut a := []u16{}
	for i := 0; i < len; i++ {
		a << reader.read_u16()
	}
	return a
}

pub fn (reader mut Reader) read_u32_array() []u32 {
	len := reader.read_i32()
	mut a := []u32{}
	for i := 0; i < len; i++ {
		a << reader.read_u32()
	}
	return a
}

pub fn (reader mut Reader) read_u64_array() []u64 {
	len := reader.read_i32()
	mut a := []u64{}
	for i := 0; i < len; i++ {
		a << reader.read_u64()
	}
	return a
}

pub fn (reader mut Reader) read_string() string {
	len := reader.read_i32()
	buf := reader.read(len)
	return string(buf)
}

pub fn (reader mut Reader) read_bool() bool {
	b := reader.read_u8()
	if b == 0x01 {
		return true
	}
	return false
}