meta:
  id: session
  file-extension: SESSION
  endian: le
seq:
  - id: header
    type: file_hdr
  - id: package
    type: package
    repeat: eos
types:
  file_hdr:
    seq:
      - id: magic
        contents: 'SOLO'
      - id: extra
        size: 12
  pkg_hdr:
    seq:
      - id: unk0
        size: 10
  package:
    seq:
      - id: separator
        type: u1
      - id: pkg_type
        type: u1
      - id: len
        type: u1
      - id: pkg_hdr
        type: pkg_hdr
      - id: body
        size: len
        type:
          switch-on: pkg_type
          cases:
            0xA0: mystery_a0
            0xA6: mystery_a6
            0xA5: vid_qual
            0x1D: ser_num_etc
            0x08: locations
            0xA3: un_etc
            _: pkg_unk
  pkg_unk:
    seq:
      - id: unk
        size-eos: true
  mystery_a0:
    seq:
      - id: unk
        size-eos: true
  mystery_a6:
    seq:
      - id: unk
        size-eos: true
  vid_qual:
    seq:
      - id: res_fps
        type: str
        size: 12
        encoding: ASCII
  ser_num_etc:
    seq:
      - id: sernum_tstamp_tagnum
        type: str
        terminator: 0
        encoding: ASCII
  locations:
    seq:
      - id: unk1
        size: 9
      - id: tagnum
        type: u1
      - id: base_gps
        type: latlon
      - id: tag_gps
        type: latlon
      - id: unk2
        size-eos: true
  latlon:
    seq:
      - id: lat
        type: u4
      - id: lon
        type: u4
      - id: elev
        type: u4
  un_etc:
    seq:
      - id: unk1
        size: 3
      - id: username
        type: str
        encoding: ASCII
        terminator: 0
        size: 41
      - id: firmware_vers
        type: str
        encoding: ASCII
        terminator: 0
        size: 8
      - id: unk_vers
        type: str
        encoding: ASCII
        terminator: 0
        size: 8