import sys
from colormath.color_objects import LabColor, XYZColor, sRGBColor
from colormath.color_conversions import convert_color

xyz = XYZColor(sys.argv[1], sys.argv[2], sys.argv[3])
rgb = convert_color(xyz, sRGBColor, target_illuminant='d50', is_upscaled=True)

print(rgb)
