# Import Libraries
import pandas as pd
import numpy as np
from Algorithms.qaav6 import qaav6
import matplotlib.pyplot as plt

# IOCCG Report 5 Synthesized Dataset will be used to demonstrate qaav6 function
filename = 'IOP_AOP_Sun30.xls'

# Read Test Dataset: Remote sensing reflectanace, wavelength, and pure water absorption and backscattering coefficients
with open(filename, 'rb') as f:
    test_Rrs = pd.read_excel(f, sheet_name='Rrs', header=8, usecols='B:AP')
    test_pw = pd.read_excel(f, sheet_name='Basics', skiprows=8,  usecols='A:C')


# Format test_pw
test_pw.columns = ['wl', 'aw', 'bbw']

# QAA version 6
# Make QAA function inputs numpy arrays
Rrs = np.array(test_Rrs.iloc[0,:])  # Just selecting the first row of Rrs
wl = np.array(test_pw.wl)
aw = np.array(test_pw.aw)
bbw = np.array(test_pw.bbw)

# Write QAA DataFrame with Absorption, Total Backscattering, and Backscattering by Particles
iop_df = qaav6(Rrs, wl, aw, bbw)

# Visualize Values
iop_df.head()

# Absorption
fig, ax = plt.subplots(figsize=(4.8, 2.4))
plt.style.use('fivethirtyeight')
ax.plot(iop_df.index.values, iop_df['a'].values)
ax.set_xlabel("Wavelength (nm)")
ax.set_ylabel("Total Absorption (m^-1)")
plt.title("Total Absorption")

# Backscattering
fig, ax = plt.subplots(figsize=(4.8, 2.4))
plt.style.use('fivethirtyeight')
ax.plot(iop_df.index.values, iop_df['bb'].values)
ax.set_xlabel("Wavelength (nm)")
ax.set_ylabel("Total Backscattering (m^-1)")
plt.title("Total Backscattering")
