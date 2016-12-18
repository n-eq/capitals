# capitals

Capitals is a small Bash project created in order to add some entertainment while working on the terminal, by learning some capitals of the world.

Example:
![alt tag](https://github.com/Marrakchino/capitals/blob/master/capitals_ex.png)

The countries and their respective capital are stored in the file capitals.txt.
The gathered information is fetched, when available, from the website http://sciencekids.co.nz/sciencefacts/countries/

In order to enable this program to run periodically, you need to 'cron' it.
First, you have to give executino permission: chmod a+x capitals.sh.
Then, if for example, you want it to run every two hours, you need to add this line to your crontab list (crontab -e):
0 */2 * * * ~/path/to/capitals.sh
