

var coll = document.getElementsByClassName("modFileCollapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("modFileActive");
    var modFileContent = this.nextElementSibling;
    if (modFileContent.style.maxHeight){
      modFileContent.style.maxHeight = null;
    } else {
      modFileContent.style.maxHeight = modFileContent.scrollHeight + "px";
    } 
  });
}


var coll2 = document.getElementsByClassName("modBranchCollapsible");
var i2;

for (i2 = 0; i2 < coll2.length; i2++) {
  coll2[i2].addEventListener("click", function() {
    this.classList.toggle("modBranchActive");
    var modBranchContent = this.nextElementSibling;
    if (modBranchContent.style.maxHeight){
      modBranchContent.style.maxHeight = null;
    } else {
      modBranchContent.style.maxHeight = modBranchContent.scrollHeight + "px";
    } 
  });
}


var coll3 = document.getElementsByClassName("modCondCollapsible");
var i3;

for (i3 = 0; i3 < coll3.length; i3++) {
  coll3[i3].addEventListener("click", function() {
    this.classList.toggle("modCondActive");
    var modCondContent = this.nextElementSibling;
    if (modCondContent.style.maxHeight){
      modCondContent.style.maxHeight = null;
    } else {
      modCondContent.style.maxHeight = modCondContent.scrollHeight + "px";
    } 
  });
}


var coll4 = document.getElementsByClassName("modToggleCollapsible");
var i4;

for (i4 = 0; i4 < coll4.length; i4++) {
  coll4[i4].addEventListener("click", function() {
    this.classList.toggle("modToggleActive");
    var modToggleContent = this.nextElementSibling;
    if (modToggleContent.style.maxHeight){
      modToggleContent.style.maxHeight = null;
    } else {
      modToggleContent.style.maxHeight = modToggleContent.scrollHeight + "px";
    } 
  });
}



function sortTable(i,n) {
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("sortable"+ i);
  switching = true;
  dir = "asc"; 
  while (switching) {
    switching = false;
    rows = table.rows;
    for (i = 1; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];
      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          shouldSwitch= true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
          shouldSwitch = true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount ++;      
    } else {
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}


