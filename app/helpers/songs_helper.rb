module SongsHelper
  def formatted_chords(song)
    "<div class=\"chords\">#{song.chords}</div>".html_safe
  end
end
