
local blog_filename = io.read("*l")
local blog_file = io.open("blog/"..blog_filename..".wmd")
local md_file = io.open("content/"..blog_filename..".md", "w")
local mail_file = io.open("mail/"..blog_filename..".txt", "w")

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
	{ "%s%s\n", "\n"}, -- trim double spaces
  { "&lt;", "<"}
}

for line in blog_file:lines() do
  local mdline = line
  local mailline = line
  mdline = mdline:gsub("#(%a+)%-([%s%w%a%päöÄÖåÅ]+)", "<h2><div id=\"%1\" class=\"small box\">&nbsp;</div>%2</h2>")
  mailline = mailline:gsub("#(%a+)%-([%s%w%a%päöÄÖåÅ]+)", "\n\n\n%2\n------------------------------------------------------------")
  mdline = mdline:gsub("##([%s%w%a%päöÄÖåÅ]+)", "<h4><div class=\"box leima\">&nbsp;</div>%1</h4>")
  mailline = mailline:gsub("##([%s%w%a%päöÄÖåÅ]+)", "%1")
  mdline = mdline:gsub("%%(%a+) ([%s%w%a%päöÄÖåÅ]+)", "<div class=\"piste %1\">%2</div>")
  mailline = mailline:gsub("%%(%a+) ([%s%w%a%päöÄÖåÅ]+)", "%2")
  md_file:write(mdline.."\n")
  if(mailline ~= "<br/>") then
    for _,v in pairs(cleaner) do
      mailline = mailline:gsub("%[.+%]%((.+)%)", "%1")
      mailline = mailline:gsub("%<http(.+)%>", "http%1")
      mailline = mailline:gsub(v[1], v[2])
    end
    mail_file:write(mailline.."\n")
  end
end

blog_file:close()
md_file:close()
