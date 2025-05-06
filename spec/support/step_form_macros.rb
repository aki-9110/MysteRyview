module StepFormMacros
  def step_form_book
    fill_in "本のタイトル", with: "そして誰もいなくなった"
    fill_in "著者", with: "アガサクリスティー"
    click_button "次へ"
    sleep 0.5
  end

  def step_form_non_spoiler
    fill_in "感想・レビュー（ネタバレなし)", with: "すごかった！"
    click_button "次へ"
    sleep 0.5
  end

  def step_form_spoiler
    fill_in "感想・レビュー（ネタバレあり)", with: "犯人は〇〇です"
    fill_in "気づいた伏線", with: "右腕の傷"
    click_button "次へ"
    sleep 0.5
  end
end
