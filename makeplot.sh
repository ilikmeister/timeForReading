#!/bin/bash

BIGFILE=$1

if [ $# -eq 0 ]; then
	echo "usage: $0 filename" >&2
	exit 1
fi

echo running read.sh script and creating the plot...

run() {
	file_output=$(./read.sh $BIGFILE)
	echo "$file_output" | head -n -1 | awk '{ print $(NF - 4), $(NF - 1) }'
}


HTML="plot.html"
TITLE="Comparing buffersize to execution time"


build_html() {
    cat << END_END
<html>
<head>
  <script type='text/javascript' src='https://www.google.com/jsapi'></script>
  <script type='text/javascript'>
    google.load('visualization', '1.1', {packages: ['line']});
    google.setOnLoadCallback(drawChart);

    function drawChart() {
      var options = {
	chart: {
	    lineWidth: 20,
	    title: '$TITLE'
	},
	vAxis: {
	  title: 'milliseconds',
	},
        width:  1000,
        height: 600
      };
      var chart = new google.charts.Line(document.getElementById('linechart_material'));
      var data = new google.visualization.DataTable();

      data.addColumn('number', 'buffersize (bytes)');
      data.addColumn('number', 'milliseconds');

      data.addRows([
END_END

    run | sed -e 's/\s/, /' -e 's/.*/	[&],/'

cat << END_END
      ]);
      chart.draw(data, options);
    }
  </script>
</head>

<body>
  <div id='linechart_material' style='margin: 4em;'></div>
</body>
</html>
END_END
}

rm -f $HTML
build_html > $HTML
echo "output is in $HTML"
