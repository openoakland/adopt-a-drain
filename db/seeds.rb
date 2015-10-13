require 'csv'
require 'open-uri'



# url = '/Users/eddie/Downloads/drainswgs84.csv'
# url = 'http://data.openoakland.org/storage/f/2012-11-01T014902/Inlets.csv'
url = 'https://raw.githubusercontent.com/qtrandev/adopt-a-drain/master/db/seeds.csv'

# puts 'removing old things data'
# Thing.destroy_all
create_thing = 0
update_thing = 0
failed_update = 0
nil_thing = 0
puts 'connecting'
open(url) do |f|
  puts 'downloading'
  f.each_line do |l|
    CSV.parse(l) do |row|

      if(row[0] == "city_id")
        next
      else
        city_id = row[0].to_i
        lat = row[1].to_f
        lng = row[2].to_f
        puts "#{row} "

        if city_id > 0



          drain = Thing.find_by_city_id( city_id )

          puts "#{city_id} #{lng} #{lat}"

          if drain
            puts "UPDATING #{city_id} #{lng} #{lat} "
            update_thing = update_thing + 1
          else
            puts "CREATING NEW #{city_id} #{lng} #{lat} "
            drain = Thing.new({:city_id => city_id, :lng => lng, :lat => lat})
            create_thing = create_thing + 1
          end


          updated_successul = false
          if !lng.nil? && !lat.nil?
            drain.update_attributes({:lng => lng, :lat => lat})
            updated_successul = drain.save!
          else
            nil_thing = nil_thing + 1

          end



          if updated_successul
            puts "SAVED"
          else
            puts "FAILED"
            failed_update = failed_update + 1
          end


        end
      end
    end
  end
end

puts "Total created #{create_thing} and #{update_thing} updated, #{failed_update} failed and #{nil_thing} were nil"


# Thing.create(:city_id =>  1, :lng => -157.74898782223062, :lat=> 21.376607020832314)
# Thing.create(:city_id =>  2, :lng => -157.83260982529868, :lat=> 21.44316202186285)
# Thing.create(:city_id =>  3, :lng => -157.92847782520883, :lat=> 21.375356017001515)
# Thing.create(:city_id =>  4, :lng => -157.93160082521447, :lat=> 21.384862017273573)
# Thing.create(:city_id =>  5, :lng => -157.75111682330962, :lat=> 21.4261480229591)
# Thing.create(:city_id =>  6, :lng => -157.85067582165888, :lat=> 21.290883014655773)
# Thing.create(:city_id =>  7, :lng => -157.8321548213673, :lat=> 21.28912701501561)
# Thing.create(:city_id =>  8, :lng => -157.84043682093125, :lat=> 21.2828820146399)
# Thing.create(:city_id =>  9, :lng => -157.8461798226548, :lat=> 21.34414801740725)
# Thing.create(:city_id =>  10, :lng => -157.9101168243043, :lat=> 21.35915801667744)
# Thing.create(:city_id =>  11, :lng => -157.91368982433966, :lat=> 21.365030016584047)
# Thing.create(:city_id =>  12, :lng => -158.11012782689667, :lat=> 21.3231000102485)
# Thing.create(:city_id =>  13, :lng => -157.71133482131077, :lat=> 21.376248021485782)
# Thing.create(:city_id =>  14, :lng => -157.71622082087887, :lat=> 21.358244020940564)
# Thing.create(:city_id =>  15, :lng => -157.843143822069, :lat=> 21.32076001619144)
# Thing.create(:city_id =>  16, :lng => -158.22406683573888, :lat=> 21.577878019617877)
# Thing.create(:city_id =>  17, :lng => -157.90418582495636, :lat=> 21.388264018119706)
# Thing.create(:city_id =>  18, :lng => -158.10009782648797, :lat=> 21.308143009715533)
# Thing.create(:city_id =>  19, :lng => -157.79582882326815, :lat=> 21.40411802098645)
# Thing.create(:city_id =>  20, :lng => -157.75538982259908, :lat=> 21.40366502201616)
# Thing.create(:city_id =>  21, :lng => -157.994118826769, :lat=> 21.409028016575462)
# Thing.create(:city_id =>  22, :lng => -157.81234081986355, :lat=> 21.256238013877024)
# Thing.create(:city_id =>  23, :lng => -158.21779483543156, :lat=> 21.577765019680786)
# Thing.create(:city_id =>  24, :lng => -157.79435481970012, :lat=> 21.268150015055905)
# Thing.create(:city_id =>  25, :lng => -157.82160482136467, :lat=> 21.296877015457156)
# Thing.create(:city_id =>  26, :lng => -158.01948182682628, :lat=> 21.38003601492668)
# Thing.create(:city_id =>  27, :lng => -158.01373082505435, :lat=> 21.31599401218161)
# Thing.create(:city_id =>  28, :lng => -158.03355982594744, :lat=> 21.34514501322552)
# Thing.create(:city_id =>  29, :lng => -158.02361582970087, :lat=> 21.49873602006822)
# Thing.create(:city_id =>  30, :lng => -157.8322488210979, :lat=> 21.28242101499991)
# Thing.create(:city_id =>  31, :lng => -157.79617581994086, :lat=> 21.259485014564294)
# Thing.create(:city_id =>  32, :lng => -157.88092882305372, :lat=> 21.339637016274896)
# Thing.create(:city_id =>  33, :lng => -157.87718582357948, :lat=> 21.35031401673813)
# Thing.create(:city_id =>  34, :lng => -157.7087988189692, :lat=> 21.295935017970496)
# Thing.create(:city_id =>  35, :lng => -158.1038018339511, :lat=> 21.600452023316592)
# Thing.create(:city_id =>  36, :lng => -158.10391883350616, :lat=> 21.58411702262625)
# Thing.create(:city_id =>  37, :lng => -157.6964498181775, :lat=> 21.274650017721303)
# Thing.create(:city_id =>  38, :lng => -157.91192483045373, :lat=> 21.613120028166456)
# Thing.create(:city_id =>  39, :lng => -157.809880824759, :lat=> 21.443964022766856)
# Thing.create(:city_id =>  40, :lng => -157.80985682416656, :lat=> 21.418354021260043)
# Thing.create(:city_id =>  41, :lng => -158.0187138308728, :lat=> 21.535475022203023)
# Thing.create(:city_id =>  42, :lng => -157.95290482465077, :lat=> 21.34174101470715)
# Thing.create(:city_id =>  43, :lng => -157.95586182403216, :lat=> 21.320893013539422)
# Thing.create(:city_id =>  44, :lng => -157.94165282440127, :lat=> 21.33671701481102)
# Thing.create(:city_id =>  45, :lng => -157.93241882383276, :lat=> 21.334976014734213)
# Thing.create(:city_id =>  46, :lng => -157.9608628245134, :lat=> 21.33610801416671)
# Thing.create(:city_id =>  47, :lng => -157.9616758240671, :lat=> 21.3262770136546)
# Thing.create(:city_id =>  48, :lng => -157.9356038238304, :lat=> 21.318621014141154)
# Thing.create(:city_id =>  49, :lng => -158.10570882742553, :lat=> 21.341345011002286)
# Thing.create(:city_id =>  50, :lng => -157.86818582257328, :lat=> 21.320691015531366)
# Thing.create(:city_id =>  51, :lng => -157.90697882348084, :lat=> 21.33183801541621)
# Thing.create(:city_id =>  52, :lng => -157.9135758236346, :lat=> 21.333161015065652)
# Thing.create(:city_id =>  53, :lng => -157.8549128220964, :lat=> 21.30432101504991)
# Thing.create(:city_id =>  54, :lng => -158.02778682653891, :lat=> 21.36314001383917)
# Thing.create(:city_id =>  55, :lng => -157.97687982427408, :lat=> 21.32304301347066)
# Thing.create(:city_id =>  56, :lng => -157.84150782582262, :lat=> 21.45931802271594)
# Thing.create(:city_id =>  57, :lng => -157.87634982862264, :lat=> 21.558734026080284)
# Thing.create(:city_id =>  58, :lng => -158.13000582800763, :lat=> 21.352261011126284)
# Thing.create(:city_id =>  59, :lng => -157.94790283263714, :lat=> 21.676660030011078)
# Thing.create(:city_id =>  60, :lng => -157.72633082215856, :lat=> 21.396294022466314)
# Thing.create(:city_id =>  61, :lng => -157.74026282215934, :lat=> 21.39574502173133)
# Thing.create(:city_id =>  62, :lng => -157.7300948215248, :lat=> 21.370650021011514)
# Thing.create(:city_id =>  63, :lng => -157.74954182313948, :lat=> 21.41290902240102)
# Thing.create(:city_id =>  64, :lng => -157.845896827792, :lat=> 21.544900026440732)
# Thing.create(:city_id =>  65, :lng => -157.87834582288363, :lat=> 21.32783901583794)
# Thing.create(:city_id =>  66, :lng => -157.86118982312033, :lat=> 21.351972017133857)
# Thing.create(:city_id =>  67, :lng => -157.87227382314913, :lat=> 21.334155016363432)
# Thing.create(:city_id =>  68, :lng => -157.68445981870823, :lat=> 21.293361018510986)
# Thing.create(:city_id =>  69, :lng => -157.75683082394616, :lat=> 21.447908023669775)
# Thing.create(:city_id =>  70, :lng => -157.81725482032934, :lat=> 21.27515801483637)
# Thing.create(:city_id =>  71, :lng => -157.80369282025674, :lat=> 21.27657801503768)
# Thing.create(:city_id =>  72, :lng => -158.0647048268991, :lat=> 21.349226012593128)
# Thing.create(:city_id =>  73, :lng => -157.80319182388092, :lat=> 21.407617021281787)
# Thing.create(:city_id =>  74, :lng => -157.75568381937035, :lat=> 21.278311016489358)
# Thing.create(:city_id =>  75, :lng => -158.0739128341717, :lat=> 21.62733602534101)
# Thing.create(:city_id =>  76, :lng => -158.08982483413348, :lat=> 21.613963024208562)
# Thing.create(:city_id =>  77, :lng => -158.0078448344824, :lat=> 21.695416029877496)
# Thing.create(:city_id =>  78, :lng => -157.80271582359893, :lat=> 21.399295020525663)
# Thing.create(:city_id =>  79, :lng => -157.85795282154297, :lat=> 21.294624014740002)
# Thing.create(:city_id =>  80, :lng => -157.80739882451016, :lat=> 21.427984021889692)
# Thing.create(:city_id =>  81, :lng => -158.01268682889688, :lat=> 21.460383018619094)
# Thing.create(:city_id =>  82, :lng => -157.85055582135453, :lat=> 21.297385015068834)
# Thing.create(:city_id =>  83, :lng => -157.83472282726564, :lat=> 21.526015025442213)
# Thing.create(:city_id =>  84, :lng => -157.72445281964025, :lat=> 21.295102017846556)
# Thing.create(:city_id =>  85, :lng => -158.06447182949844, :lat=> 21.461427017522674)
# Thing.create(:city_id =>  86, :lng => -158.0519738299445, :lat=> 21.475950018505653)
# Thing.create(:city_id =>  87, :lng => -157.83214482529525, :lat=> 21.45939702289368)
# Thing.create(:city_id =>  88, :lng => -157.7135378219587, :lat=> 21.388976022461602)
# Thing.create(:city_id =>  89, :lng => -158.01077982968604, :lat=> 21.498587020417453)
# Thing.create(:city_id =>  90, :lng => -158.17845583067609, :lat=> 21.424877013505082)
# Thing.create(:city_id =>  91, :lng => -158.17699783010798, :lat=> 21.404381012424786)
# Thing.create(:city_id =>  92, :lng => -158.196644832502, :lat=> 21.4752320152021)
# Thing.create(:city_id =>  93, :lng => -158.0835458272797, :lat=> 21.348993012026142)
# Thing.create(:city_id =>  94, :lng => -157.83750682147138, :lat=> 21.302775015747844)
# Thing.create(:city_id =>  95, :lng => -158.20611183223983, :lat=> 21.45979301453494)
# Thing.create(:city_id =>  96, :lng => -157.79011682079684, :lat=> 21.295470016522497)
# Thing.create(:city_id =>  97, :lng => -157.71603781878292, :lat=> 21.283257017424443)
# Thing.create(:city_id =>  98, :lng => -157.76356982235515, :lat=> 21.37254202059158)
# Thing.create(:city_id =>  99, :lng => -158.01522782827166, :lat=> 21.451293018202275)
# Thing.create(:city_id =>  100, :lng => -157.98983882843382, :lat=> 21.471167019577646)
# Thing.create(:city_id =>  101, :lng => -157.99885982831643, :lat=> 21.463277019229132)
# Thing.create(:city_id =>  102, :lng => -158.00645882895915, :lat=> 21.47088901933723)
# Thing.create(:city_id =>  103, :lng => -157.99672182900528, :lat=> 21.479559020205272)
# Thing.create(:city_id =>  104, :lng => -158.01887182820258, :lat=> 21.43231801727201)
# Thing.create(:city_id =>  105, :lng => -158.0143588290843, :lat=> 21.48198901944057)
# Thing.create(:city_id =>  106, :lng => -157.8902628236568, :lat=> 21.349338016466824)
# Thing.create(:city_id =>  107, :lng => -157.88046282397227, :lat=> 21.37424101763897)
# Thing.create(:city_id =>  108, :lng => -157.77135582325556, :lat=> 21.410547021858594)
# Thing.create(:city_id =>  109, :lng => -158.19669383494892, :lat=> 21.58087402044294)
# Thing.create(:city_id =>  110, :lng => -158.1512158341522, :lat=> 21.57340702075577)
# Thing.create(:city_id =>  111, :lng => -158.18046183454405, :lat=> 21.579834020437964)
# Thing.create(:city_id =>  112, :lng => -158.1426468289115, :lat=> 21.378572011948677)
# Thing.create(:city_id =>  113, :lng => -158.15981782945417, :lat=> 21.394275012640936)
# Thing.create(:city_id =>  114, :lng => -157.9094558251303, :lat=> 21.39477701826225)
# Thing.create(:city_id =>  115, :lng => -158.07360882546814, :lat=> 21.299189009743564)
# Thing.create(:city_id =>  116, :lng => -157.8327688223107, :lat=> 21.342877017412988)
# Thing.create(:city_id =>  117, :lng => -157.9520558266261, :lat=> 21.42574301853092)
# Thing.create(:city_id =>  118, :lng => -157.79689882075843, :lat=> 21.299517016144886)
# Thing.create(:city_id =>  119, :lng => -157.9694428262645, :lat=> 21.393374016645687)
# Thing.create(:city_id =>  120, :lng => -157.96301582625452, :lat=> 21.402912017268495)
# Thing.create(:city_id =>  121, :lng => -157.95582882669225, :lat=> 21.415251017883918)
# Thing.create(:city_id =>  122, :lng => -157.8788028225911, :lat=> 21.320769015416566)
# Thing.create(:city_id =>  123, :lng => -157.92233583137326, :lat=> 21.636515028602346)
# Thing.create(:city_id =>  124, :lng => -157.99820782452016, :lat=> 21.314119012371098)
# Thing.create(:city_id =>  125, :lng => -157.87585142246277, :lat=> 21.56928305686768)
# Thing.create(:city_id =>  126, :lng => -157.88335982928228, :lat=> 21.577647026730236)
# Thing.create(:city_id =>  127, :lng => -158.04663283393126, :lat=> 21.64552502662107)
# Thing.create(:city_id =>  128, :lng => -157.8246358213948, :lat=> 21.31030101608435)
# Thing.create(:city_id =>  129, :lng => -158.1330238339621, :lat=> 21.581169021905904)
# Thing.create(:city_id =>  130, :lng => -157.89957142357613, :lat=> 21.603323058055302)
# Thing.create(:city_id =>  131, :lng => -157.91047582414865, :lat=> 21.352961016285786)
# Thing.create(:city_id =>  132, :lng => -157.88722682321992, :lat=> 21.328377015388227)
# Thing.create(:city_id =>  133, :lng => -157.87128082224936, :lat=> 21.30311401501926)
# Thing.create(:city_id =>  134, :lng => -157.67354781829516, :lat=> 21.28831601863615)
# Thing.create(:city_id =>  135, :lng => -158.05870283034758, :lat=> 21.499077019254226)
# Thing.create(:city_id =>  136, :lng => -158.04929483019527, :lat=> 21.48773001897003)
# Thing.create(:city_id =>  137, :lng => -158.06195983032302, :lat=> 21.489631018941324)
# Thing.create(:city_id =>  138, :lng => -158.080082830953, :lat=> 21.491899018696458)
# Thing.create(:city_id =>  139, :lng => -158.07019983092889, :lat=> 21.501769019235088)
# Thing.create(:city_id =>  140, :lng => -157.66153357545718, :lat=> 21.311734787240624)
# Thing.create(:city_id =>  141, :lng => -157.88982282360212, :lat=> 21.336857015856182)
# Thing.create(:city_id =>  142, :lng => -158.0631398340273, :lat=> 21.646076026298616)
# Thing.create(:city_id =>  143, :lng => -158.04004283456464, :lat=> 21.674241028026643)
# Thing.create(:city_id =>  144, :lng => -158.05160383434702, :lat=> 21.66341002720093)
# Thing.create(:city_id =>  145, :lng => -157.85265682835822, :lat=> 21.55599902655402)
# Thing.create(:city_id =>  146, :lng => -157.89665882389028, :lat=> 21.35976001659018)
# Thing.create(:city_id =>  147, :lng => -157.88473082409124, :lat=> 21.3656500174639)
# Thing.create(:city_id =>  148, :lng => -157.98661583388738, :lat=> 21.697613030142982)
# Thing.create(:city_id =>  149, :lng => -158.02784082743034, :lat=> 21.389938014933648)
# Thing.create(:city_id =>  150, :lng => -157.99563282983857, :lat=> 21.509711021468043)
# Thing.create(:city_id =>  151, :lng => -157.77757281971574, :lat=> 21.27049301559295)
# Thing.create(:city_id =>  152, :lng => -158.12391783381614, :lat=> 21.576042021558642)
# Thing.create(:city_id =>  153, :lng => -158.19220083164953, :lat=> 21.450976014465105)
# Thing.create(:city_id =>  154, :lng => -158.2011158318622, :lat=> 21.45685601444641)
# Thing.create(:city_id =>  155, :lng => -158.18469183120425, :lat=> 21.437443013927464)
# Thing.create(:city_id =>  156, :lng => -157.84521582644632, :lat=> 21.483165023383712)
# Thing.create(:city_id =>  157, :lng => -157.75456981965175, :lat=> 21.293383017135724)
# Thing.create(:city_id =>  158, :lng => -157.94906082582506, :lat=> 21.390490017165284)
# Thing.create(:city_id =>  159, :lng => -157.73942982074732, :lat=> 21.34259401980951)
# Thing.create(:city_id =>  160, :lng => -157.69488782005618, :lat=> 21.331240019963758)
# Thing.create(:city_id =>  161, :lng => -157.7149768202957, :lat=> 21.342226020236374)
# Thing.create(:city_id =>  162, :lng => -158.06830683422734, :lat=> 21.633542025295704)
# Thing.create(:city_id =>  163, :lng => -157.9947748264404, :lat=> 21.389103015915467)
# Thing.create(:city_id =>  164, :lng => -157.99972682741034, :lat=> 21.41751801731743)
# Thing.create(:city_id =>  165, :lng => -158.01945083005862, :lat=> 21.510946021049175)
# Thing.create(:city_id =>  166, :lng => -157.78429982008112, :lat=> 21.281191015653494)
# Thing.create(:city_id =>  167, :lng => -157.80305482135455, :lat=> 21.316619017048804)
# Thing.create(:city_id =>  168, :lng => -157.70420151822051, :lat=> 21.26312934688229)
# Thing.create(:city_id =>  169, :lng => -157.68383481898852, :lat=> 21.306896019196543)
# Thing.create(:city_id =>  170, :lng => -158.03283482553962, :lat=> 21.329912682456115)
# Thing.create(:city_id =>  171, :lng => -158.17710153050268, :lat=> 21.416179343209556)
# Thing.create(:city_id =>  172, :lng => -158.07565152660166, :lat=> 21.333712681485853)
# Thing.create(:city_id =>  173, :lng => -158.05665152554553, :lat=> 21.305562680724595)
# Thing.create(:city_id =>  174, :lng => -157.92276813168795, :lat=> 21.64734602947919)
# Thing.create(:city_id =>  175, :lng => -158.22261813326296, :lat=> 21.47887601489222)
# Thing.create(:city_id =>  176, :lng => -158.2162848324896, :lat=> 21.470246014598548)
# Thing.create(:city_id =>  177, :lng => -158.01736615525047, :lat=> 21.33226754604477)
