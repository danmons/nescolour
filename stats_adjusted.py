import sys
import numpy

file = open(sys.argv[1], "r")
vals = []

for de in file.readlines():
  vals.append(float(de))

file.close

mean = round(numpy.mean(vals), 2)
std = round(numpy.std(vals), 2)
tth = round(numpy.percentile(vals, 10), 2)
nth = round(numpy.percentile(vals, 90), 2)
#min = round(numpy.amin(vals), 2)
max = round(numpy.amax(vals), 2)


print("de_mean:", mean)
print("de_standard_deviation:", std)
#print("min:", min)
print("de_10th_percentile:", tth)
print("de_90th_percentile:", nth)
print("de_max:", max)
