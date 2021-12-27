echo "4" > /sys/class/gpio/export
echo "5" > /sys/class/gpio/export
echo "6" > /sys/class/gpio/export
echo "12" > /sys/class/gpio/export
echo "22" > /sys/class/gpio/export
echo "26" > /sys/class/gpio/export
echo "27" > /sys/class/gpio/export
echo "18" > /sys/class/gpio/export
echo "13" > /sys/class/gpio/export
echo "23" > /sys/class/gpio/export
echo "24" > /sys/class/gpio/export

sleep 0.4
echo "out" > /sys/class/gpio/gpio4/direction
echo "out" > /sys/class/gpio/gpio5/direction
echo "out" > /sys/class/gpio/gpio6/direction
echo "out" > /sys/class/gpio/gpio12/direction
echo "out" > /sys/class/gpio/gpio22/direction
echo "out" > /sys/class/gpio/gpio26/direction
echo "out" > /sys/class/gpio/gpio27/direction
echo "out" > /sys/class/gpio/gpio18/direction
echo "out" > /sys/class/gpio/gpio13/direction
echo "out" > /sys/class/gpio/gpio23/direction
echo "out" > /sys/class/gpio/gpio24/direction

echo "0" > /sys/class/gpio/gpio4/value
echo "1" > /sys/class/gpio/gpio5/value
echo "1" > /sys/class/gpio/gpio6/value
echo "1" > /sys/class/gpio/gpio12/value
echo "1" > /sys/class/gpio/gpio22/value
echo "1" > /sys/class/gpio/gpio26/value
echo "1" > /sys/class/gpio/gpio27/value
echo "0" > /sys/class/gpio/gpio18/value
echo "0" > /sys/class/gpio/gpio13/value
echo "0" > /sys/class/gpio/gpio23/value
echo "0" > /sys/class/gpio/gpio24/value


