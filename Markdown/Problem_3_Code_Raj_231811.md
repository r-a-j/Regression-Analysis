## Project - 3 
(Winter Semester 2022 - 2023)\
Regression Analysis\
Author - Raj Anilbhai Pawar\
Matriculation Number - 231811\
Group - 17\
Raj Anilbhai Pawar\
Amritha Sukhdev Singh Agarwal\
Sagar Basnet\
Muhammad Fahad\
Siddhartha Kark


```python
import pandas as pd
import os
```


```python
# Creating a directory for plots if it doesn't exist

if not os.path.isdir('Plots'):
    os.mkdir("Plots")
```


```python
# Read dataset
data = pd.read_csv("bodymeasurements.csv")
data
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Age</th>
      <th>Sex</th>
      <th>ID</th>
      <th>Height</th>
      <th>Chest</th>
      <th>Belly</th>
      <th>Thigh</th>
      <th>Knee</th>
      <th>Calf</th>
      <th>Ankle</th>
      <th>Biceps</th>
      <th>Wrist</th>
      <th>Weight</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>21</td>
      <td>m</td>
      <td>1</td>
      <td>174.0</td>
      <td>89.5</td>
      <td>71.5</td>
      <td>51.5</td>
      <td>34.5</td>
      <td>36.5</td>
      <td>23.5</td>
      <td>32.5</td>
      <td>16.5</td>
      <td>65.6</td>
    </tr>
    <tr>
      <th>1</th>
      <td>23</td>
      <td>m</td>
      <td>2</td>
      <td>175.3</td>
      <td>97.0</td>
      <td>79.0</td>
      <td>51.5</td>
      <td>36.5</td>
      <td>37.5</td>
      <td>24.5</td>
      <td>34.4</td>
      <td>17.0</td>
      <td>71.8</td>
    </tr>
    <tr>
      <th>2</th>
      <td>28</td>
      <td>m</td>
      <td>3</td>
      <td>193.5</td>
      <td>97.5</td>
      <td>83.2</td>
      <td>57.3</td>
      <td>37.0</td>
      <td>37.3</td>
      <td>21.9</td>
      <td>33.4</td>
      <td>16.9</td>
      <td>80.7</td>
    </tr>
    <tr>
      <th>3</th>
      <td>23</td>
      <td>m</td>
      <td>4</td>
      <td>186.5</td>
      <td>97.0</td>
      <td>77.8</td>
      <td>53.0</td>
      <td>37.0</td>
      <td>34.8</td>
      <td>23.0</td>
      <td>31.0</td>
      <td>16.6</td>
      <td>72.6</td>
    </tr>
    <tr>
      <th>4</th>
      <td>22</td>
      <td>m</td>
      <td>5</td>
      <td>187.2</td>
      <td>97.5</td>
      <td>80.0</td>
      <td>55.4</td>
      <td>37.7</td>
      <td>38.6</td>
      <td>24.4</td>
      <td>32.0</td>
      <td>18.0</td>
      <td>78.8</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>419</th>
      <td>29</td>
      <td>f</td>
      <td>420</td>
      <td>176.5</td>
      <td>91.8</td>
      <td>69.9</td>
      <td>60.6</td>
      <td>37.7</td>
      <td>37.9</td>
      <td>22.4</td>
      <td>30.3</td>
      <td>15.4</td>
      <td>71.8</td>
    </tr>
    <tr>
      <th>420</th>
      <td>21</td>
      <td>f</td>
      <td>421</td>
      <td>164.4</td>
      <td>87.3</td>
      <td>63.5</td>
      <td>55.2</td>
      <td>35.6</td>
      <td>33.3</td>
      <td>22.4</td>
      <td>30.1</td>
      <td>15.2</td>
      <td>55.5</td>
    </tr>
    <tr>
      <th>421</th>
      <td>33</td>
      <td>f</td>
      <td>422</td>
      <td>160.7</td>
      <td>78.1</td>
      <td>57.9</td>
      <td>51.8</td>
      <td>34.4</td>
      <td>34.1</td>
      <td>21.2</td>
      <td>27.4</td>
      <td>15.5</td>
      <td>48.6</td>
    </tr>
    <tr>
      <th>422</th>
      <td>33</td>
      <td>f</td>
      <td>423</td>
      <td>174.0</td>
      <td>90.9</td>
      <td>72.2</td>
      <td>59.0</td>
      <td>38.4</td>
      <td>36.6</td>
      <td>22.0</td>
      <td>30.6</td>
      <td>15.5</td>
      <td>66.4</td>
    </tr>
    <tr>
      <th>423</th>
      <td>38</td>
      <td>f</td>
      <td>424</td>
      <td>163.8</td>
      <td>97.1</td>
      <td>80.4</td>
      <td>57.4</td>
      <td>39.6</td>
      <td>35.9</td>
      <td>23.0</td>
      <td>33.2</td>
      <td>16.4</td>
      <td>67.3</td>
    </tr>
  </tbody>
</table>
<p>424 rows × 13 columns</p>
</div>




```python
round(data.describe(), 2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Age</th>
      <th>ID</th>
      <th>Height</th>
      <th>Chest</th>
      <th>Belly</th>
      <th>Thigh</th>
      <th>Knee</th>
      <th>Calf</th>
      <th>Ankle</th>
      <th>Biceps</th>
      <th>Wrist</th>
      <th>Weight</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
      <td>424.00</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>26.90</td>
      <td>212.50</td>
      <td>170.88</td>
      <td>92.22</td>
      <td>75.28</td>
      <td>56.82</td>
      <td>36.01</td>
      <td>35.88</td>
      <td>22.03</td>
      <td>30.83</td>
      <td>15.97</td>
      <td>67.82</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5.85</td>
      <td>122.54</td>
      <td>9.40</td>
      <td>9.60</td>
      <td>9.90</td>
      <td>4.43</td>
      <td>2.54</td>
      <td>2.76</td>
      <td>1.85</td>
      <td>4.27</td>
      <td>1.35</td>
      <td>12.74</td>
    </tr>
    <tr>
      <th>min</th>
      <td>18.00</td>
      <td>1.00</td>
      <td>147.20</td>
      <td>72.60</td>
      <td>57.90</td>
      <td>46.30</td>
      <td>29.00</td>
      <td>28.40</td>
      <td>16.40</td>
      <td>22.40</td>
      <td>13.00</td>
      <td>42.00</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>22.00</td>
      <td>106.75</td>
      <td>163.20</td>
      <td>84.78</td>
      <td>67.50</td>
      <td>53.70</td>
      <td>34.30</td>
      <td>34.00</td>
      <td>20.90</td>
      <td>27.28</td>
      <td>14.88</td>
      <td>57.30</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>25.00</td>
      <td>212.50</td>
      <td>170.20</td>
      <td>90.95</td>
      <td>74.10</td>
      <td>56.30</td>
      <td>35.90</td>
      <td>35.80</td>
      <td>21.90</td>
      <td>30.35</td>
      <td>15.90</td>
      <td>66.80</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>31.25</td>
      <td>318.25</td>
      <td>177.80</td>
      <td>99.82</td>
      <td>82.00</td>
      <td>59.50</td>
      <td>37.70</td>
      <td>37.70</td>
      <td>23.10</td>
      <td>34.12</td>
      <td>17.00</td>
      <td>75.62</td>
    </tr>
    <tr>
      <th>max</th>
      <td>40.00</td>
      <td>424.00</td>
      <td>198.10</td>
      <td>116.70</td>
      <td>113.20</td>
      <td>75.70</td>
      <td>45.70</td>
      <td>45.00</td>
      <td>29.30</td>
      <td>42.40</td>
      <td>19.60</td>
      <td>105.20</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Checking nans
nan_rows = data[data.isnull().any(axis=1)]
print("NAN Rows: ", len(nan_rows))
```

    NAN Rows:  0
    
