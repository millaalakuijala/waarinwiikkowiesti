
-- list of strings to replace (the order is important to avoid conflicts)
local cleaner = {
	{ "&amp;", "&" }, -- decode ampersands
	{ "&#151;", "-" }, -- em dash
	{ "&#146;", "'" }, -- right single quote
	{ "&#147;", "\"" }, -- left double quote
	{ "&#148;", "\"" }, -- right double quote
	{ "&#150;", "-" }, -- en dash
	{ "&#160;", " " }, -- non-breaking space
	{ "&nbsp;", ""}, -- custom header mark
	{ "<br ?/?>", "\n" }, -- all <br> tags whether terminated or not (<br> <br/> <br />) become new lines
	{ "</p>", "\n" }, -- ends of paragraphs become new lines
	{ "(%b<>)", "" }, -- all other html elements are completely removed (must be done last)
	{ "\r", "\n" }, -- return carriage become new lines
	{ "[\n\n]+", "\n" }, -- reduce all multiple new lines with a single new line
	{ "^\n*", "" }, -- trim new lines from the start...
	{ "\n*$", "" }, -- ... and end
	{ "%s%s\n", "\n"} -- trim double spaces
}

-- clean html from the string
function cleanstr(str)
	for i=1, #cleaner do
		local cleans = cleaner[i]
		str = string.gsub(str, cleans[1], cleans[2])
	end
	return str
end

for i=0,100 do
  local md = io.open("content/"..i..".md", "r")
  if(md) then
    local mail = io.open("mail/"..i..".txt", "w")
    for line in md:lines() do
      line = line:gsub("%[.+%]%((.+)%)", "%1")
      line = line:gsub("%<http(.+)%>", "http%1")
      line = cleanstr(line)
      mail:write(line.."\n")
    end
    mail:close()
    md:close()
  end
end

