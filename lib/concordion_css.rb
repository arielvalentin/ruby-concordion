 

module ConcordionCSS
  def self.css_string
    css = <<-eoscss
* {
  font-family: Arial;
}
body {
  padding: 32px;
}
pre {
  padding: 6px 28px 6px 28px;
  background-color: #E8EEF7;
}
pre, pre *, code, kbd {
  font-family: Courier New, Courier;
  font-size: 10pt;
}
h1, h1 * {
  font-size: 24pt;
}
p, td, th, li, .breadcrumbs {
  font-size: 10pt;
}
p, li {
  line-height: 140%;
}
table {
  border-collapse: collapse;
  empty-cells: show;
  margin: 8px 0px 8px 0px;
}
th, td {
  border: 1px solid black;
  padding: 3px;
}
td {
  background-color: white;
  vertical-align: top;
}
th {
  background-color: #C3D9FF;
}
li {
  margin-top: 6px;
  margin-bottom: 6px;
}


.example {
  padding: 2px 12px 6px 12px;
  border: 1px solid #C3D9FF;
  margin: 6px 0px 28px 0px;
  background-color: #F5F9FD;
}
.example h3 {
  margin-top: 8px;
  margin-bottom: 8px;
  font-size: 12pt;
}

p.success {
  padding: 2px;
}
.concordion_success, .concordion_success * {
  background-color: #afa !important;
}
.success pre {
  background-color: #bbffbb;
}
.concordion_failure, .concordion_failure * {
  background-color: #ffb0b0;
  padding: 1px;
}
.concordion_failure .expected {
  text-decoration: line-through;
  color: #bb5050;
}

ins {
  text-decoration: none;
}

.exceptionMessage {
  background-color: #fdd;
  font-family: Courier New, Courier, Monospace;
  font-size: 10pt;
  display: block;
  font-weight: normal;
  padding: 4px;
  text-decoration: none !important;
}
.stackTrace, .stackTrace * {
  font-weight: normal;
}
.stackTrace {
  display: none;
  padding: 1px 4px 4px 4px;
  background-color: #fdd;
  border-top: 1px dotted black;
}
.stackTraceExceptionMessage {
  display: block;
  font-family: Courier New, Courier, Monospace;
  font-size: 8pt;
  white-space: wrap;
  padding: 1px 0px 1px 0px;
}
.stackTraceEntry {
  white-space: nowrap;
  font-family: Courier New, Courier, Monospace;
  display: block;
  font-size: 8pt;
  padding: 1px 0px 1px 32px;
}
.stackTraceButton {
  font-size: 8pt;
  margin: 2px 8px 2px 0px;
  font-weight: normal;
  font-family: Arial;
}

.special {
  font-style: italic;
}
.missing, .missing * {
  background-color: #ff9999;
}
.surplus, .surplus * {
  background-color: #ff9999;
}
.footer {
  text-align: right;
  margin-top: 40px;
  font-size: 8pt;
  width: 100%;
  color: #999;
}
.footer .testTime {
  padding: 2px 10px 0px 0px;
}

.idea {
  font-size: 9pt;
  color: #888;
  font-style: italic;
}
.tight li {
  margin-top: 1px;
  margin-bottom: 1px;
}
.commentary {
  float: right;
  width: 200px;
  background-color: #ffffd0;
  padding:8px;
  border: 3px solid #eeeeb0;
  margin: 10px 0px 10px 10px;
}
.commentary, .commentary * {
  font-size: 8pt;
}
  eoscss
  
  css.strip  
  end
end
