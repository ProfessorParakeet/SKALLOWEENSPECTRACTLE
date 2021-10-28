-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Four' then
		duration = tonumber(value1);
		if duration < 1.5 then
			duration = 1.5;
		end

		targetAlpha = tonumber(value2);
		if duration == 1.5 then
		noteTweenX(test, 4, 110, 0.2, linear);
	end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end