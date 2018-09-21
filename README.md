# open_your_url

## Howto
    $ git clone https://github.com/cobodo/open_your_url.git ~/.mikutter/plugin/open_your_url

右下にボタンが追加されるので、押すとURLを入力するダイアログが出ます。
TweetやTootのPermalinkや、そんな感じに見えるものを入力してOKを押すと、新しいタブで開けます。

試してみたい？ここにトゥートのURLがあるじゃろ

https://social.mikutter.hachune.net/@toshi_a/99042151964910739

## For plugin developers

    Plugin.call(:open_your_url, Diva::URI.new('https://social.mikutter.hachune.net/@toshi_a/99042151964910739'))

とか
	url1 = Diva::URI.new('https://social.mikutter.hachune.net/@shijin/100682038574042041')
	url2 = Diva::URI.new('https://social.mikutter.hachune.net/@ahiru/100744958997677442')
    Plugin.call(:open_your_url, [url1, url2])

みたいにすると、ダイアログを介さずに直接指定したやつが開けます。

また、fork元である https://github.com/osak/show_tweet と同等の機能も残してあります。

    Plugin.call(:show_tweet, 43341783446466560)

    Plugin.call(:show_tweet, [2525213939, 3939252521])

ただし、[twitter_api_keys](https://github.com/toshia/twitter_api_keys)でAPI keyを上書きしてtwitterアカウントを登録している必要があります。

## アイコンについて
https://github.com/ionic-team/ionicons の md-open.svg を利用しています。

