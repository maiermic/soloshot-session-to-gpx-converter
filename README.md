# soloshot-session-to-gpx-converter

[![Join the chat at https://gitter.im/maiermic/soloshot-session-to-gpx-converter](https://badges.gitter.im/maiermic/soloshot-session-to-gpx-converter.svg)](https://gitter.im/maiermic/soloshot-session-to-gpx-converter?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Extract the GPS tracks of Soloshot 3 base and tags of a session file as GPX file.
[Try it out](https://maiermic.github.io/soloshot-session-to-gpx-converter/index.html).

## Session File Format
_The following information is also available [here](session.ksy) as a [Kaitai Struct](https://kaitai.io/) file._

The session file is a binary file. The first 4 bytes represent the ASCII encoded string `SOLO`. They are followed by 12 bytes of as yet unknown information (probably contains file version number). They are followed by packages that start with a byte `0xAA` (package separator), followed by the package type (1 byte), package data length (1 byte), package header (10 bytes) and the package data.


<table>
  <tr>
    <th></th>
    <th colspan="5">File Content</th>
  </tr>
  <tr>
    <th>File Header</th>
    <td>4 bytes (SOLO)</td>
    <td colspan="5">12 bytes</td>
  </tr>
  <tr>
    <th>1. Package</th>
    <td>1 byte (separator)</td>
    <td>1 byte (type)</td>
    <td>1 byte (data length)</td>
    <td>10 byte (header)</td>
    <td>n<sub>1</sub> bytes (data)</td>
  </tr>
  <tr>
    <th>2. Package</th>
    <td>1 byte (separator)</td>
    <td>1 byte (type)</td>
    <td>1 byte (data length)</td>
    <td>10 byte (header)</td>
    <td>n<sub>2</sub> bytes (data)</td>
  </tr>
  <tr>
    <th></th>
    <td colspan="5">...</td>
  </tr>
</table>

### Packages

| Type | Total Data Length |
| ---- | ----------------: |
| 0xA0 |          11 bytes |
| 0xA6 |          16 bytes |
| 0xA5 |          21 bytes |
| 0xA4 |          32 bytes |
| 0x1D |          43 bytes |
| 0x08 |          44 bytes |
| 0xA3 |          69 bytes |

The content of the package header is unknown yet, as is the content of the package data of package type `0xA0` and `0xA6`. The content of the other packages is partly figured out. The following tables show the structure of them. Byte order of numbers is big endian. Strings are ASCII encoded and zero terminated.

<table>
    <tr>
        <th>Type</th>
        <td colspan="2">0xA50C02</td>
    </tr>
    <tr>
        <th>Length</th>
        <td>10 bytes</td>
        <td>12 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>unknown</td>
        <td>contains video resolution and FPS (zero right padded string)</td>
    </tr>
</table>


<table>
    <tr>
        <th>Type</th>
        <td colspan="4">0xA41702</td>
    </tr>
    <tr>
        <th>Length</th>
        <td>9 bytes</td>
        <td>7 bytes</td>
        <td>8 bytes</td>
        <td>8 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>unknown</td>
        <td>base firmware version (string)</td>
        <td>unknown version number (string)</td>
        <td>camera firmware version (string)</td>
    </tr>
</table>

<table>
    <tr>
        <th>Type</th>
        <td colspan="2">0x1D2201</td>
    </tr>
    <tr>
        <th>Length</th>
        <td>9 bytes</td>
        <td>34 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>unknown</td>
        <td>comma separated string: serial number, time stamp, tag number</td>
    </tr>
</table>

<table>
    <tr>
        <th>Type</th>
        <td colspan="5">0x082301</td>
    </tr>
    <tr>
        <th>Length</th>
        <td>9 bytes</td>
        <td>1 byte</td>
        <td>12 bytes</td>
        <td>12 bytes</td>
        <td>10 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>unknown</td>
        <td>tag number</td>
        <td>GPS position of base (see table below)</td>
        <td>GPS position of tag (see table below)</td>
        <td>unknown</td>
    </tr>
</table>

<table>
    <tr>
        <th colspan="4">GPS position</th>
    </tr>
    <tr>
        <th>Length</th>
        <td>4 bytes</td>
        <td>4 bytes</td>
        <td>4 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>latitude (integer)</td>
        <td>longitude (integer)</td>
        <td>height in centimeters (integer)</td>
    </tr>
</table>

Latitude and longitude values divided by `1,000,000` result in decimal degree values.

<table>
    <tr>
        <th>Type</th>
        <td colspan="4">0xA33C02</td>
    </tr>
    <tr>
        <th>Length</th>
        <td>12 bytes</td>
        <td>41 bytes</td>
        <td>8 bytes</td>
        <td>8 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>unknown</td>
        <td>username (zero right padded string)</td>
        <td>tag firmware version (string)</td>
        <td>unknown version number (string)</td>
    </tr>
</table>
