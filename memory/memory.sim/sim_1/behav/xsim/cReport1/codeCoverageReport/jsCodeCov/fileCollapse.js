var coll = document.getElementsByClassName("fileCollapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("fileActive");
    var fileContent = this.nextElementSibling;
    if (fileContent.style.maxHeight){
      fileContent.style.maxHeight = null;
    } else {
      fileContent.style.maxHeight = fileContent.scrollHeight + "px";
    } 
  });
}


var coll2 = document.getElementsByClassName("fileBranchCollapsible");
var i2;

for (i2 = 0; i2 < coll2.length; i2++) {
  coll2[i2].addEventListener("click", function() {
    this.classList.toggle("fileBranchActive");
    var fileBranchContent = this.nextElementSibling;
    if (fileBranchContent.style.maxHeight){
      fileBranchContent.style.maxHeight = null;
    } else {
      fileBranchContent.style.maxHeight = fileBranchContent.scrollHeight + "px";
    } 
  });
}


var coll3 = document.getElementsByClassName("fileCondCollapsible");
var i3;

for (i3 = 0; i3 < coll3.length; i3++) {
  coll3[i3].addEventListener("click", function() {
    this.classList.toggle("fileCondActive");
    var fileCondContent = this.nextElementSibling;
    if (fileCondContent.style.maxHeight){
      fileCondContent.style.maxHeight = null;
    } else {
      fileCondContent.style.maxHeight = fileCondContent.scrollHeight + "px";
    } 
  });
}


var coll4 = document.getElementsByClassName("fileToggleCollapsible");
var i4;

for (i4 = 0; i4 < coll4.length; i4++) {
  coll4[i4].addEventListener("click", function() {
    this.classList.toggle("fileToggleActive");
    var fileToggleContent = this.nextElementSibling;
    if (fileToggleContent.style.maxHeight){
      fileToggleContent.style.maxHeight = null;
    } else {
      fileToggleContent.style.maxHeight = fileToggleContent.scrollHeight + "px";
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


