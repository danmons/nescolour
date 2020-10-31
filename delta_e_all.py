import sys
from colormath.color_objects import LabColor
from colormath.color_diff import delta_e_cie1976
from colormath.color_diff import delta_e_cie1994
from colormath.color_diff import delta_e_cie2000

# Expects 6 numbers
# 1-3 L*a*b* values of the reference colour
# 4-6 L*a*b* values of the colour we're comparing

# Reference colour
colour_ref = LabColor(lab_l=sys.argv[1], lab_a=sys.argv[2], lab_b=sys.argv[3])

# Colour we're comparing to reference
colour_compare = LabColor(lab_l=sys.argv[4], lab_a=sys.argv[5], lab_b=sys.argv[6])

# Calculate the Delta E values
delta_e_76 = delta_e_cie1976(colour_ref, colour_compare)
delta_e_94 = delta_e_cie1994(colour_ref, colour_compare, K_L=1, K_C=1, K_H=1, K_1=0.045, K_2=0.015)
delta_e_2000 = delta_e_cie2000(colour_ref, colour_compare, Kl=1, Kc=1, Kh=1)

# Print Delta E values
print('dE76:', delta_e_76, 'de94:', delta_e_94, 'dE2000:', delta_e_2000)
