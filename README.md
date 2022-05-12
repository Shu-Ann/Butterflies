# Butterfly Survey Visualisation

The dataset is based on `Butterfly biodiversity survey 2017`(https://data.melbourne.vic.gov.au/Environment/Butterfly-biodiversity-survey-2017/kmtd-nvqr).

This project will only include a modified subset of the original data which contains the records of the
observations in 15 sites during January to March in 2017 at City of Melbourne's public green spaces.


## Introduction 
The project is to use `R Shiny`, `ggplot2`, and `Leaflet` to create a data visualisation using the modified dataset.
The output is a one-page webpage, with some basic information, statistical charts and map with a range slider -

<img width="404" alt="截圖 2022-05-12 下午10 29 19" src="https://user-images.githubusercontent.com/105199493/168074857-5f4bb035-2ef8-4d69-aa4a-7f80dd4ec258.png">


## Output

<img width="1001" alt="截圖 2022-05-12 下午10 31 53" src="https://user-images.githubusercontent.com/105199493/168075307-5d738bed-3655-474f-bca4-e760807e756e.png">

The two charts below are bar chart and scatter plot. Bar chart shows the top 5 sites in the data based on the total number of butterflies observed in 2017, and the scatter plot graph tells that the total number of butterflies observed each day at the same 5 sites. 

Readers can use the range slider to choose the range of butterflies counted, and the size of shape refer to the total numbers of butterflies counted at the sites. By clicking the circle symbol on the map, readers can see the details of the sites.
 
<img width="774" alt="截圖 2022-05-13 上午1 44 59" src="https://user-images.githubusercontent.com/105199493/168115519-504700f9-f00b-490f-9201-366b2f37bf5a.png">



While choosing the range from 30 to 60, the map only displays the sites that between the range of total number of butterflies observed.

<img width="783" alt="截圖 2022-05-13 上午1 40 36" src="https://user-images.githubusercontent.com/105199493/168114646-bfcb445f-18ee-4c3c-899b-b4d2a5761b2e.png">


### R file

To explore more about the code, check out `Butterflies.R` file !
