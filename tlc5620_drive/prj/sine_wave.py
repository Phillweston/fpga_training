import math

# Parameters
num_points = 256
max_value = 2047

# Generate sine wave values
sine_wave = [(int((math.sin(2 * math.pi * i / num_points) + 1) * (max_value / 2))) for i in range(num_points)]

# Print the values in the desired format
for i, value in enumerate(sine_wave):
    print(f"sine_wave[{i}] = 11'd{value};")