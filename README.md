# nl-rse survey figures
This repo contains the Jupyter notebook used to generate figures for blog post on [NL-RSE 2023 survey](https://nl-rse.org/posts/2023-05-25-rse-survey-2023-results)

Dependencies are recorded in the `requirements.txt` file.

## A note about the data used
Data is loaded from the file `NL-RSE_survey_december-6-2022_scrubbed.csv`. This data file has been processed to remove columns where personal identifiable information could be found.

## Side note on using XKCD style
I had to install fonts (because it was the first time using xkcd). If fonts are missing, this magic line removes any warnings about fonts:

`%%capture --no-display`

The commands I used to install required fonts:




```bash
# Installing fonts via package manager
sudo apt-get install -y fonts-humor-sans
sudo apt-get install -y fonts-comic-neue
sudo apt-get install ttf-mscorefonts-installer

# Installing fonts from GitHub repo https://github.com/ipython/xkcd-font
sudo mkdir /usr/share/fonts/truetype/xkcd-script
cd /usr/share/fonts/truetype/xkcd-script/
sudo wget https://github.com/ipython/xkcd-font/raw/master/xkcd-script/font/xkcd-script.ttf

sudo mkdir /usr/share/fonts/truetype/xkcd
cd /usr/share/fonts/truetype/xkcd
sudo wget https://github.com/ipython/xkcd-font/raw/master/xkcd/build/xkcd.otf

# Clear matplotlib font cache and restart notebook
rm ~/.cache/matplotlib/fontlist-v330.json
#Restart notebook and run all again
```
