# soloshot-session-to-gpx-converter

[![Join the chat at https://gitter.im/maiermic/soloshot-session-to-gpx-converter](https://badges.gitter.im/maiermic/soloshot-session-to-gpx-converter.svg)](https://gitter.im/maiermic/soloshot-session-to-gpx-converter?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Extract the GPS tracks of Soloshot 3 base and tags of a session file as GPX file.
[Try it out](https://maiermic.github.io/soloshot-session-to-gpx-converter/index.html).

## Session File Format
The session file is a binary file. The first 4 bytes represent the ASCII encoded string `SOLO`. They are followed by 12 bytes of as yet unknown information (probably contains file version number). They are followed by packages that start with a byte `0xAA` (package separator), followed by 3 bytes (package type) and the package data, whose length depends on the package type.

<table>
  <tr>
    <td>4 bytes (SOLO)</td>
    <td colspan="2">12 bytes</td>
  </tr>
  <tr>
    <td>1 byte (package separator)</td>
    <td>3 bytes (package type)</td>
    <td>n<sub>0</sub> bytes (package data)</td>
  </tr>
  <tr>
    <td>1 byte (package separator)</td>
    <td>3 bytes (package type)</td>
    <td>n<sub>1</sub> bytes (package data)</td>
  </tr>
  <tr>
    <td colspan="3">...</td>
  </tr>
</table>

### Packages

| Type     | Total Data Length |
| -------- | ----------------: |
| 0xA00201 |          11 bytes |
| 0xA60702 |          16 bytes |
| 0xA50C02 |          21 bytes |
| 0xA41702 |          32 bytes |
| 0x1D2201 |          43 bytes |
| 0x082301 |          44 bytes |
| 0xA33C02 |          69 bytes |

The content of the packages `0xA00201` and `0xA60702` is unknown yet. The content of the other packages is partly figured out. The following tables show the structure of them. Byte order of numbers is big endian. Strings are ASCII encoded and zero terminated.

<table>
    <tr>
        <th>Type</th>
        <td colspan="2">0xA50C02</td>
    </tr>
    <tr>
        <th>Length</th>
        <td>10 bytes</td>
        <td>11 bytes</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>unknown</td>
        <td>video resolution and FPS (zero right padded string)</td>
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
