export function delForm(delid) {
  var child = document.getElementById(delid);
  var parent = child.parentNode;
  parent.remove();
}