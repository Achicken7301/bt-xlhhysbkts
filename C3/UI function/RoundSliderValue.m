function slider_value = RoundSliderValue(value)
    if isa(value,"string")
        value=str2num(value);
    end
    slider_value=round(value);
end