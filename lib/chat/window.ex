defmodule Chat.Window do
  import Bitwise

  @display 1
  @user 12
  @text 13
  @send 14

  def start do
    wx = :wx.new
    panel = :wxFrame.new(wx, -1, 'Phoenix Chat')
    display = setup(panel)
    :wxFrame.show(panel)
  end

  def setup(panel) do

    rows       = :wxBoxSizer.new(:wx_const.wx_vertical)
    second_row = :wxBoxSizer.new(:wx_const.wx_horizontal)
    display    = :wxTextCtrl.new(panel, @display, value: "display",
                  style: :wx_const.wx_multiline)

    :wxSizer.add(rows, display, proportion: 8, flag: (:wx_const.wx_expand ||| :wx_const.wx_all))
    :wxSizer.add(rows,second_row, proportion: 2,flag: (:wx_const.wx_expand ||| :wx_const.wx_all))


    user = :wxTextCtrl.new(panel, @user, value: "user")
    text = :wxTextCtrl.new(panel, @text, value: "text")
    send = :wxButton.new(panel,   @send, label: "Send!")

    #:wxSizer.add(first_row,display)
    :wxSizer.add(second_row,user,proportion: 2)
    :wxSizer.add(second_row,text,proportion: 6)
    :wxSizer.add(second_row,send,proportion: 2)


    :wxPanel.setSizerAndFit(panel, rows)
  end
end
