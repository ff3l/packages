return function(form, uci)

	local pkg_i18n = i18n 'gluon-config-mode-segment-mover'

	local msg = pkg_i18n.translate(
		'Your node can switch its domain automatically by asking an ' ..
	        'API for the correct domain for the geo coordinates. ' ..
	        'If you would not like this behaviour, you can disable it here.'
	)

	local s = form:section(Section, nil, msg)

	local noautodomain = s:option(Flag, "noautodomain", pkg_i18n.translate("Don't use API to get Domain"))
	noautodomain.default = uci:get_bool("gluon", "core", "noautodomain")
	function noautodomain:write(data)
		uci:set("gluon", "core", "noautodomain", data)
	end

	return {'gluon'}
end
