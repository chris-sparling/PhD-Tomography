function showim(image,contrast)

map = write_colour_map('red/blue');

%map = write_colour_map('difference');

%image = image/max(abs(image(:)));

%contrast = round(1/mean(mean(image(201+[-5 5],261+[-5 5]))))

surf(image)
shading interp
axis off
view([0 90])
colormap(map)
caxis(max(max(abs(image)))*(1/contrast)*[-1 1])
pbaspect([1 1 1])



end

