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
  cs_association_div.className = cv_association + '_wrap_' + columnname +  ' flex';
  parent.appendChild(cs_association_div);

  var input_data = document.createElement('textarea');
  var del_button = document.createElement('button');
  input_data.name = 'cv[' + cv_association + '_attributes][' + i + '][' + columnname + ']';
  input_data.className = "w-5/12 bg-gray-100 rounded border border-gray-400 leading-normal resize-none \
                         w-full h-24 py-2 px-3 mb-3 font-medium placeholder-gray-700 focus:outline-none focus:bg-white";
  input_data.id = 'cv_' + cv_association + '_attributes_' + i + '_' + columnname;
  del_button.type = 'button';
  del_button.append('取消');
  del_button.className = "base_button bg-white text-red-500 hover:bg-red-500 hover:text-white border-red-500";
  del_button.id = cv_association + '_' + columnname + '_del_' + i;

  var button_flex_div = document.createElement('div');
  button_flex_div.id = 'button_flex_div_' + cv_association + '_' + i ;
  button_flex_div.className = "flex flex-col w-2/12 place-content-center mx-2";
  var label_button_wrap1 = document.createElement('div');
  var label_button_wrap2 = document.createElement('div');

  label_button_wrap1.id = 'label_button_wrap1_' + cv_association + '_' + i ;
  label_button_wrap1.className = 'my-1';
  label_button_wrap2.id = 'label_button_wrap2_' + cv_association + '_' + i ;
  label_button_wrap2.className = 'my-1';

  cs_association_div.appendChild(input_data);
  cs_association_div.appendChild(button_flex_div);
  button_flex_div = document.getElementById('button_flex_div_' + cv_association + '_' + i);

  button_flex_div.appendChild(label_button_wrap1);
  button_flex_div.appendChild(label_button_wrap2);

  label_button_wrap1 = document.getElementById('label_button_wrap1_' + cv_association + '_' + i);
  label_button_wrap1.appendChild(del_button);

  var display_label = document.createElement('label');
  var display_checkbox = document.createElement('input');
  display_label.append('表示する');
  display_checkbox.type = 'checkbox';
  display_checkbox.checked = true;
  display_checkbox.name = 'cv[' + cv_association + '_attributes][' + i + '][display]';
  display_checkbox.id = 'cv_' + cv_association + '_attributes_' + i + '_display';

  label_button_wrap2 = document.getElementById('label_button_wrap2_' + cv_association + '_' + i);
  label_button_wrap2.appendChild(display_label);
  label_button_wrap2.appendChild(display_checkbox);
  
  //追加ボタンの位置を変更するため
  parent.appendChild(cv_association_add_button);

  let delbutton = document.getElementById(cv_association + '_' + columnname + '_del_' + i);
  delbutton.addEventListener('click', () => delForm(delbutton.id));

  eval(cv_association + '_itr++');
}
