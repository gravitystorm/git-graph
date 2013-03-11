Make graphs from your git history

Install
=======

    gem install git-graph

Usage
=====

```Bash
# number of lines in the readme as csv
git-graph --interval day --output csv "cat Readme.md | wc -l"
2013-02-01,24
2013-01-31,24
2013-01-31,22
...
```

```Bash
# number of lines in the readme as line-chart (via google charts)
git-graph --interval week --output chart "wc -l Readme.md"
```
![Chart](http://chart.apis.google.com/chart?chs=600x200&cht=lc&chxt=x,y&chxl=0:|2009-05-23|2013-03-09|1:|0|97&chd=s:hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiijjjkkkkkkkkkkkkkkkkllloooooooooooooooooooooopppppqqqqqqqqqqqqrrrrrrssssssssssssssssssssssssssssssssssssss2222222999999999999999&chdl=Lines&chtt=Readme+lines)

```Bash
# number of gems the project depends on
git-graph --interval year --output chart "cat Gemfile.lock | grep DEPENDENCIES -A 999 | wc -l"

# number of lines of code
git-graph --interval year --output chart "find . -name '*.rb' | xargs wc -l | tail -1"

# application startup time
git-graph --interval year --bundle --output chart '(time -p bundle exec rails runner) 2>&1 | grep real | tail -1 | cut -d " " -f 2'
```

If the script fails the previous output is assumed.

TODO
====
 - interval month -> first of every month ?
 - interval year -> same day on every year (leap-year adjustment)
 - refactor into a class
 - [spark](https://github.com/topfunky/sparklines) chart ?

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/git-graph.png)](https://travis-ci.org/grosser/git-graph)
