<!DOCTYPE html>
<html>

<head>
    <title>Read Text File</title>
</head>

<body>
    <script>
        function readTextFile(file)
        {
            var rawFile = new XMLHttpRequest();
            rawFile.open("GET", file, false);
            rawFile.onreadystatechange = function ()
            {
                if(rawFile.readyState === 4)
                {
                    if(rawFile.status === 200 || rawFile.status == 0)
                    {
                        var allText = rawFile.responseText;
                        alert(allText);
                    }else{}
                }
            }
            rawFile.send(null);
        }

        readTextFile("file:///F:/web/Apache24/htdocs/count_blink.txt");

    </script>
</body>

</html>