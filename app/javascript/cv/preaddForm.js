import { delForm } from './del';

var objectives_itr ;
var skills_itr ;
var summaries_itr ;
var qualifications_itr ;
var work_experiences_itr ;

export function preaddForm(cv_association, columnname) {
  var cv_association_add_button = document.getElementById(cv_association + '_button');
  var parent = cv_association_add_button.parentNode;
  var parent_tag = parent.getElementsByClassName(cv_association + '_wrap_' + columnname);
  eval(cv_association + '_itr = ' + parent_tag.length);
  cv_association_add_button.addEventListener('click', () => addForm(parent, cv_association, columnname, cv_association_add_button));
}

function addForm(parent, cv_association, columnname, cv_association_add_button) {
  var cs_association_div = document.createElement('div');
  var i = eval(cv_association + '_itr');
  cs_association_div.className = cv_association + '_wrap_' + columnname;
  parent.appendChild(cs_association_div);

  var input_data = document.createElement('textarea');
  var del_button = document.createElement('button');
  input_data.name = 'cv[' + cv_association + '_attributes][' + i + '][' + columnname + ']';
  input_data.id = 'cv_' + cv_association + '_attributes_' + i + '_' + columnname;
  del_button.type = 'button';
  del_button.id = cv_association + '_' + columnname + '_del_' + i;

  var destroy_label = document.createElement('label');
  destroy_label.append("取消");

  cs_association_div.appendChild(input_data);
  cs_association_div.appendChild(destroy_label);
  cs_association_div.appendChild(del_button);

  var display_label = document.createElement('label');
  var display_checkbox = document.createElement('input');
  display_label.append("表示する");
  display_checkbox.type = 'checkbox';
  display_checkbox.checked = true;
  display_checkbox.name = 'cv[' + cv_association + '_attributes][' + i + '][display]';
  display_checkbox.id = 'cv_' + cv_association + '_attributes_' + i + '_display';

  cs_association_div.appendChild(display_label);
  cs_association_div.appendChild(display_checkbox);
  
  //追加ボタンの位置を変更するため
  parent.appendChild(cv_association_add_button);

  let delbutton = document.getElementById(cv_association + '_' + columnname + '_del_' + i);
  delbutton.addEventListener('click', () => delForm(delbutton.id));

  eval(cv_association + '_itr++');
}
