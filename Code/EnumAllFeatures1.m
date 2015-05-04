function all_ftypes = EnumAllFeatures(W, H)

all_ftypes = zeros(40000, 5);
i = 1;

for type = 1:4
  switch type
    case 1
      for w = 1:W - 1
        for h = 1:floor(H / 2) - 1
          for x = 1:W - w
            for y = 1:H - 2 * h
              all_ftypes(i, :) = [type x y w h];
              i = i + 1;
            end
          end
        end
      end
    case 2
      for w = 1:floor(W / 2) - 1
        for h = 1:H - 1
          for x = 1:W - 2 * w
            for y = 1:H - h
              all_ftypes(i, :) = [type x y w h];
              i = i + 1;
            end
          end
        end
      end
    case 3
      for w = 1:floor(W / 3) - 1
        for h = 1:H - 1
          for x = 1:W - 3 * w
            for y = 1:H - h
              all_ftypes(i, :) = [type x y w h];
              i = i + 1;
            end
          end
        end
      end
    case 4
      for w = 1:floor(W / 2) - 1
        for h = 1:floor(H / 2) - 1
          for x = 1:W - 2 * w
            for y = 1:H - 2 * h
              all_ftypes(i, :) = [type x y w h];
              i = i + 1;
            end
          end
        end
      end
    otherwise
      disp('Not happening');
  end
end

all_ftypes(all(all_ftypes == 0, 2), :) = [];