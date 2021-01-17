//イベントデリゲート

(() => {
  document.addEventListener('click', function(e) {
    var el = e.target;
    while (el && el !== document) {
      if (el.getAttribute('class') === 'Reply_micropost') {
        // 子要素で起きた全てのイベントを受け取る
        // イベント記述
        var eventID = e.target.id;
        var main_micropost_id =eventID.replace('Reply_micropost_','')
        var micropost_form_wrap = document.getElementById('micropost_form_wrap');

        // replyする投稿を投稿フォームの上にコピーする。
        var main_micropost_block = document.getElementById( 'micropost-' + main_micropost_id );
        var clone_main_micropost = main_micropost_block.cloneNode(true);
        clone_main_micropost.removeChild(clone_main_micropost.childNodes.item(7));
        clone_main_micropost.id = 'disp_micropost';

        var appended_disp_div = document.createElement('div');
        appended_disp_div.id = 'appended_disp_wrap';

        var reply_cancel_buttton = document.createElement('button');
        reply_cancel_buttton.id = 'reply_cancel_buttton';
        reply_cancel_buttton.type = 'button';
        reply_cancel_buttton.append('リプライをキャンセル');

        var appended_disp_wrap = document.getElementById('appended_disp_wrap');

        if ( appended_disp_wrap != null ) {
          appended_disp_wrap.remove();
          appended_disp_chk()
        } else {
          appended_disp_chk()
        }

        // 投稿フォームにreplyするmicropostのIDのパラメータを追加する。(main_micropost_id)
        var micropost_form_field = document.getElementById('micropost_form_field');
        var reply_hidden_input = document.createElement('input');
        reply_hidden_input.type = 'hidden';
        reply_hidden_input.id = 'reply_relationship[main_micropost_id]';
        reply_hidden_input.name = 'reply_relationship[main_micropost_id]';
        reply_hidden_input.value =  main_micropost_id;

        var appended_reply_field = document.getElementById('reply_relationship[main_micropost_id]');

        if (appended_reply_field != null) {
          appended_reply_field.remove();
          micropost_form_field.appendChild(reply_hidden_input);
        } else {
          micropost_form_field.appendChild(reply_hidden_input);
        }
        break;

        ////////////関数///////////////////////////////////////////////
        function appended_disp_chk() {
          micropost_form_wrap.before(appended_disp_div);
          appended_disp_wrap = document.getElementById('appended_disp_wrap');
          appended_disp_wrap.appendChild(reply_cancel_buttton);
          appended_disp_wrap.appendChild(clone_main_micropost);

          reply_cancel_buttton = document.getElementById('reply_cancel_buttton');
          reply_cancel_buttton.addEventListener('click', () => replyCancel());
        }

        function replyCancel(){
          appended_disp_wrap = document.getElementById('appended_disp_wrap');
          appended_disp_wrap.remove();

          appended_reply_field = document.getElementById('reply_relationship[main_micropost_id]');
          appended_reply_field.remove();
        }
        ////////////関数///////////////////////////////////////////////

      }
      // イベントの起こった要素からdocument（４行目のdocument）まで、親要素を参照する。
      el = el.parentNode;
    }
  }, false);
})();
