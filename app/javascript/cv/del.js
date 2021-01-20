export function delForm(delid) {
  var child = document.getElementById(delid);
  var parent = child.parentNode.parentNode.parentNode;
  parent.remove();
}