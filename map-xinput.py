import subprocess
import os
result = subprocess.check_output(['lsusb', '-t'])
#print result
lines = result.splitlines()
data = {
  'usb': {},
  'xinput': {}
}
port = -1
for line in lines:
  line = line.decode('utf-8')

  if line.startswith("        |__ Port "):
    port = line[17]
    print('found ' + port)
    print(line)

  if ((port == '1') or (port == '2')) and (line.find('Driver=usbhid') > -1):
    print('found xinput id')
    line = line[line.find(' Dev ')+5:]
    line = line[0:line.find(',')]
    data['usb'][line] = port
    #line = 'xinput map-to-output ' + line + ' HDMI-' + port
    #print line
    #os.system(line)

result = subprocess.check_output(['xinput'])
#print result
lines = result.splitlines()
for line in lines:
  line = line.decode('utf-8')

  if (line.find('ILITEK') > -1) and (line.find('Mouse') == -1):
    line = line[line.find('id=')+3:]
    line = line[0:line.find('\t')]

    allinfo = subprocess.check_output(['xinput', 'list-props', line])
    allinfo = allinfo.splitlines()
    for info in allinfo:
      info = info.decode('utf-8')
      if (info.find('/dev/input/event') > -1):
        info = info[info.find('/dev/input/event')+16:]
        info = info[0:info.find('"')]
        data['xinput'][line] = info

        udevadm = subprocess.check_output(['udevadm', 'info', '-a', '/dev/input/event' + info])
        udevadm = udevadm.splitlines()
        for dev in udevadm:
          dev = dev.decode('utf-8')
          if (dev.find('devnum') > -1):
            dev = dev[dev.find('=="')+3:]
            dev = dev[0:dev.find('"')]
            mapCommand = 'xinput map-to-output ' + line + ' HDMI-' + data['usb'][dev]
            print(mapCommand)
            os.system(mapCommand)
            break

# input("Press Enter to continue...")
print(data)
