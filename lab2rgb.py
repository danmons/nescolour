import sys
from colormath.color_objects import LabColor, XYZColor, sRGBColor
from colormath.color_conversions import convert_color

lab = LabColor(sys.argv[1], sys.argv[2], sys.argv[3])
rgb = convert_color(lab, sRGBColor, target_illuminant='d50')

red = rgb.clamped_rgb_r
green = rgb.clamped_rgb_g
blue = rgb.clamped_rgb_b

red = str(int(round(red*255)))
green = str(int(round(green*255, 0)))
blue = str(int(round (blue*255, 0)))

col = red+','+green+','+blue

print(col)
