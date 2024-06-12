<html>
<head>
  <title>Echoing HTML Request Parameters</title>
</head>
<body>
  <h3>Choose the technology that you like:</h3>
  <form method="get">
    <input type="checkbox" name="author" value="Amazon Web Services">Cloud
    <input type="checkbox" name="author" value="Google Cloud Platform">Cloud
    <input type="checkbox" name="author" value="DevOps">Automation
    <input type="checkbox" name="author" value="Docker & Kubernetes">Containers
    <input type="checkbox" name="author" value="Kafka & Airflow">BigData
    <input type="checkbox" name="author" value="Python & Bash">Scripting
    <input type="submit" value="Query">
  </form>

  <%
  String[] authors = request.getParameterValues("author");
  if (authors != null) {
  %>
    <h3>You have selected the technology(s):</h3>
    <ul>
  <%
      for (int i = 0; i < authors.length; ++i) {
  %>
        <li><%= authors[i] %></li>
  <%
      }
  %>
    </ul>
    <a href="<%= request.getRequestURI() %>">BACK</a>
  <%
  }
  %>
</body>
</html>
