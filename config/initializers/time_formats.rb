Time::DATE_FORMATS[:datetime_jp] = '%Y年%m月%d日 %H時%M分'
# :datetime_jpは別の名前でも可
# viewでの呼び出し方　<%= article.created_at.to_s(:datetime_jp) %>