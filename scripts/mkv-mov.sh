echo "This script will convert between MKV to MOV and vice versa"

# Set default path
DEFAULT_PATH=~/Projects/Video/
echo "Default path is $DEFAULT_PATH"

# Set option and name
echo "(1)MKV -> MOV | (2) MOV -> MP4"
read OPTION
echo "Type filename"
read FILENAME

if [ $OPTION -eq 1 ]; then
	ffmpeg -i $FILENAME.mkv -map 0:0 -map 0:1 -map 0:2? -vcodec dnxhd -acodec:0 pcm_s16le -acodec:1 pcm_s16le -s 1920x1080 -r 30000/1001 -b:v 36M -pix_fmt yuv422p -f mov $FILENAME.mov



