-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Six' then
		duration = tonumber(value1);
		if duration < 1.5 then
			duration = 1.5;
		end

		targetAlpha = tonumber(value2);
		if duration == 1.5 then
		noteTweenX(test, 6, 350, 0.2, linear);
	end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end