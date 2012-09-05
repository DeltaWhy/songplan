module SongsHelper
  def formatted_chords(song, key)
    s = '<div class="chords">'.html_safe
    song.transpose(key).lines.each do |line|
      s += formatted_line(line.rstrip) + "\n"
    end
    s += '</div>'.html_safe
    return s
  end

  def formatted_line(line)
    if Song.is_header(line)
      '<strong>'.html_safe + line + '</strong>'.html_safe
    else
      line.html_safe
    end
  end
end
