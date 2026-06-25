# SynComDesign 涓枃浣跨敤鎵嬪唽

鏈墜鍐岄潰鍚戞病鏈?MATLAB銆丆OBRA Toolbox銆佷唬璋㈡ā鍨嬪拰 FBA 鍩虹鐨勭敤鎴枫€傚彧瑕佹寜姝ラ鎿嶄綔锛屽氨鍙互鐢?SynComDesign 璇诲彇鑿屾牚浠ｈ阿妯″瀷銆佽缃煿鍏诲熀銆佹灇涓捐弻鏍粍鍚堬紝骞惰緭鍑虹敓闀垮拰鍙嶇鍖栫浉鍏抽娴嬬粨鏋溿€?
## 1. SynComDesign 鏄仛浠€涔堢殑

SynComDesign 鐢ㄤ簬璁捐鍜岃瘎浠峰悎鎴愬井鐢熺墿缇よ惤銆傚畠浼氭妸澶氫釜鑿屾牚鐨勫熀鍥犵粍灏哄害浠ｈ阿妯″瀷缁勫悎璧锋潵锛屽湪鍚屼竴涓叡浜煿鍏荤幆澧冧腑妯℃嫙瀹冧滑鐨勭敓闀垮拰鍔熻兘琛ㄧ幇銆?
褰撳墠鐗堟湰涓昏鏀寔锛?
- CarveMe 鐢熸垚鐨?COBRA/SBML 妯″瀷銆?- BiGG 椋庢牸鐨勪唬璋㈢墿鍜屽弽搴?ID銆?- 鍗曡弻鏍拰澶氳弻鏍粍鍚堣嚜鍔ㄦ灇涓俱€?- 缇よ惤鎬荤敓鐗╅噺棰勬祴銆?- 鎸囧畾鐩爣鑿岀敓鐗╅噺棰勬祴銆?- 绛夋瘮渚嬫垨鍥哄畾姣斾緥缇よ惤缁勬垚绾︽潫銆?- 鐢熼暱浼樺厛銆佸啀浼樺寲 N2O 娑堣€楃殑浜岄樁娈电洰鏍囥€?- 纭濋吀鐩愩€佷簹纭濋吀鐩愩€佷竴姘у寲姘€佹哀鍖栦簹姘拰姘皵浜ゆ崲閫氶噺杈撳嚭銆?- 缁撴灉鑷姩淇濆瓨涓?TSV 鍜?CSV 琛ㄦ牸銆?
## 2. 浣犻渶瑕佸噯澶囦粈涔?
鏈€灏戦渶瑕佸噯澶囦笁绫讳笢瑗匡細

1. 杞欢鐜銆?2. 鑿屾牚浠ｈ阿妯″瀷銆?3. 鍩瑰吇鍩洪厤缃枃浠躲€?
### 2.1 杞欢鐜

闇€瑕佸畨瑁咃細

- MATLAB銆?- COBRA Toolbox銆?- 涓€涓?LP 姹傝В鍣紝渚嬪 Gurobi 鎴?GLPK銆?
鎺ㄨ崘浼樺厛浣跨敤 Gurobi锛屽洜涓?GLPK 鍦ㄩ儴鍒?COBRA 妯″瀷涓婂彲鑳芥洿瀹规槗鍑虹幇鏁板€奸棶棰樸€?
### 2.2 鑿屾牚妯″瀷

妯″瀷鍙互鏄細

- `.xml`
- `.sbml`
- `.mat`
- `.json`

褰撳墠椤圭洰榛樿璇诲彇椤圭洰鏍圭洰褰曚笅鐨?XML 妯″瀷锛屼緥濡傦細

```text
models\005.xml
models\016.xml
models\020.xml
models\E10.xml
models\ER45.xml
```

濡傛灉浣犳崲鎴愯嚜宸辩殑妯″瀷锛屽缓璁ā鍨嬫枃浠跺悕鐩存帴鐢ㄨ弻鏍悕锛屼緥濡傦細

```text
strainA.xml
strainB.xml
strainC.xml
```

杈撳嚭琛ㄤ腑鐨勭粍鍚堝悕浼氫娇鐢ㄨ繖浜涙枃浠跺悕銆?
### 2.3 鍩瑰吇鍩烘枃浠?
鍩瑰吇鍩烘枃浠舵槸锛?
```text
media/medium.tsv
```

瀹冨憡璇夌▼搴忓摢浜涘婧愯惀鍏荤墿鍙互琚憚鍙栵紝浠ュ強鎽勫彇涓嬬晫鏄灏戙€?
## 3. 绗竴娆¤繍琛?
鎵撳紑 MATLAB锛岃緭鍏ワ細

```matlab
cd('D:\superCC\SynComDesign')
addpath(genpath(pwd))
```

鍒濆鍖?COBRA Toolbox 鍜屾眰瑙ｅ櫒锛?
```matlab
initCobraToolbox(false);
changeCobraSolver('gurobi', 'LP');
```

鐒跺悗杩愯锛?
```matlab
results = runSynComDesign('config/syncomdesign_config.yml');
```

濡傛灉杩愯鎴愬姛锛孧ATLAB 浼氭樉绀虹被浼硷細

```text
Models detected: 5
Models validated: 5
Biomass reactions detected: 5
Total combinations: 31
Feasible combinations: 31
Failed combinations: 0
Output directory: D:\superCC\SynComDesign\results
```

缁撴灉浼氫繚瀛樺埌閰嶇疆鏂囦欢閲岀殑 `output_dir` 鏂囦欢澶逛腑銆?
## 4. 閰嶇疆鏂囦欢鍦ㄥ摢閲?
涓婚厤缃枃浠舵槸锛?
```text
config/syncomdesign_config.yml
```

涔熷彲浠ヤ娇鐢?JSON 鐗堟湰锛?
```text
```

鎺ㄨ崘鍒濆鑰呬紭鍏堜慨鏀?YAML 鏂囦欢锛屽洜涓哄畠鏇村鏄撹銆?
## 5. 閰嶇疆鏂囦欢閫愰」瑙ｉ噴

涓嬮潰鏄父瑙侀厤缃粨鏋勶細

```yaml
project:
  name: SynComDesign
  output_dir: results

models:
  directory: models
  file_pattern: "*.xml"
  biomass_reactions_file: config/biomass_reactions.tsv
  metabolite_aliases_file: config/metabolite_aliases.tsv

combinations:
  min_size: 1
  max_size: null
  required_species: []
  excluded_species: []
  enumerate_all: true
  max_combinations: 100000

medium:
  file: media/medium.tsv
  condition: anaerobic
  close_unlisted_uptakes: true

community:
  require_all_species_active: true
  minimum_biomass_flux: 1.0e-6
  shared_environment_compartment: u

objective:
  scenario_id: 5
  type: growth_then_n2o_consumption
  growth_fraction: 0.9
  target_strain: null
  biomass_weights: equal

analysis:
  run_fva: true
  fva_fraction_of_optimum: 90
  save_community_models: false
  continue_on_error: true

solver:
  name: gurobi
  feasibility_tolerance: 1.0e-9
  optimality_tolerance: 1.0e-9
```

### 5.1 output_dir

姣忔杩愯鐨勭粨鏋滀繚瀛樹綅缃敱杩欓噷鍐冲畾锛?
```yaml
project:
  output_dir: results
```

濡傛灉浣犱笉鎯宠鐩栨棫缁撴灉锛屽彲浠ユ敼鎴愶細

```yaml
output_dir: results_ID1_growth
```

鎴栵細

```yaml
output_dir: results_ID2_E10
```

### 5.2 models.directory

妯″瀷鎵€鍦ㄦ枃浠跺す锛?
```yaml
models:
  directory: models
```

`.` 琛ㄧず褰撳墠 SynComDesign 椤圭洰鏍圭洰褰曘€?
濡傛灉浣犳妸妯″瀷鏀惧埌 `input_models` 鏂囦欢澶癸紝鍙互鏀规垚锛?
```yaml
models:
  directory: input_models
```

### 5.3 models.file_pattern

鎸囧畾璇诲彇鍝簺妯″瀷鏂囦欢锛?
```yaml
file_pattern: "*.xml"
```

琛ㄧず璇诲彇鎵€鏈?XML 妯″瀷銆?
### 5.4 combinations.min_size 鍜?max_size

鎺у埗缁勫悎澶у皬锛?
```yaml
min_size: 1
max_size: null
```

鍚箟鏄粠鍗曡弻鏍粍鍚堜竴鐩磋窇鍒版墍鏈夎弻鏍粍鍚堛€?
濡傛灉鍙兂璺?2 鍒?3 涓弻鏍殑缁勫悎锛?
```yaml
min_size: 2
max_size: 3
```

### 5.5 required_species

寮哄埗缁勫悎閲屽繀椤诲寘鍚煇浜涜弻鏍紪鍙枫€?
绋嬪簭璇诲彇妯″瀷鏃朵細鎸夋枃浠跺悕鎺掑簭銆傚綋鍓嶄簲涓ā鍨嬮€氬父瀵瑰簲锛?
```text
1 = 005
2 = 016
3 = 020
4 = E10
5 = ER45
```

濡傛灉浣犳兂鎵€鏈夌粍鍚堥兘蹇呴』鍖呭惈 E10锛?
```yaml
required_species: [4]
```

ID2 鎸囧畾鐩爣鑿屾椂锛岀▼搴忎細鑷姩鍙灇涓惧寘鍚洰鏍囪弻鐨勭粍鍚堬紝涓€鑸笉闇€瑕佹墜鍔ㄥ啓 `required_species`銆?
### 5.6 excluded_species

鎺掗櫎鏌愪簺鑿屾牚銆?
渚嬪涓嶆兂浣跨敤 ER45锛?
```yaml
excluded_species: [5]
```

### 5.7 medium.file

鍩瑰吇鍩烘枃浠讹細

```yaml
medium:
  file: media/medium.tsv
```

鎹㈠煿鍏诲熀鏃讹紝鏈€鎺ㄨ崘鐨勫仛娉曟槸鏂板缓涓€涓枃浠讹紝渚嬪锛?
```text
config/medium_low_nitrate.tsv
```

鐒跺悗鏀规垚锛?
```yaml
medium:
  file: config/medium_low_nitrate.tsv
```

### 5.8 close_unlisted_uptakes

```yaml
close_unlisted_uptakes: true
```

琛ㄧず娌℃湁鍐欏湪鍩瑰吇鍩烘枃浠堕噷鐨勮惀鍏荤墿榛樿涓嶅厑璁告憚鍙栥€傝繖涓缃洿涓ユ牸锛屼篃鏇撮€傚悎閬垮厤妯″瀷鍋峰悆鏈厤缃殑钀ュ吇鐗┿€?
## 6. objective.scenario_id 鎬庝箞閫?
SynComDesign 淇濈暀浜?ID 椋庢牸鐨勭洰鏍囬€夋嫨銆?
### ID1锛氭渶澶у寲缇よ惤鎬荤敓鐗╅噺

閰嶇疆锛?
```yaml
objective:
  scenario_id: 1
```

鐢ㄩ€旓細

- 鐪嬪摢涓粍鍚堟暣浣撻暱寰楁渶濂姐€?- 閫傚悎浼樺厛绛涢€夐珮鐢熼暱閲忕粍鍚堛€?
绋嬪簭浼氳嚜鍔ㄨВ閲婁负锛?
```text
total_biomass
```

### ID2锛氭渶澶у寲鎸囧畾鐩爣鑿岀敓鐗╅噺

閰嶇疆锛?
```yaml
objective:
  scenario_id: 2
  target_strain: E10
```

鐢ㄩ€旓細

- 鎯宠鏌愪釜鐩爣鑿屽敖閲忛暱寰楀ソ銆?- 渚嬪浣犲叧蹇?E10 鏄惁鑳借鍏朵粬鑿屾牚淇冭繘銆?
娉ㄦ剰锛?
- `target_strain` 蹇呴』鍜屾ā鍨嬫枃浠跺悕涓€鑷淬€?- 濡傛灉妯″瀷鏂囦欢鏄?`E10.xml`锛屽氨鍐?`E10`銆?- 绋嬪簭浼氳嚜鍔ㄥ彧璺戝寘鍚洰鏍囪弻鐨勭粍鍚堛€?
濡傛灉缁撴灉閲?E10 鐢熺墿閲忎粛鐒舵槸 0锛岃鏄庡湪褰撳墠妯″瀷鍜屽煿鍏诲熀绾︽潫涓嬶紝E10 鍙兘涓嶈兘鐢熼暱銆傛鏃惰妫€鏌ュ煿鍏诲熀銆丒10 妯″瀷鍜?biomass reaction銆?
### ID3锛氱瓑姣斾緥缁勬垚

閰嶇疆锛?
```yaml
objective:
  scenario_id: 3
```

鐢ㄩ€旓細

- 瑕佹眰缁勫悎涓悇鑿屾牚 biomass 閫氶噺淇濇寔绛夋瘮渚嬨€?- 渚嬪涓よ弻鏍粍鍚堜腑涓や釜鑿屾牚鐨?biomass 鐩哥瓑銆?
杩欓€傚悎妯℃嫙浜轰负閰嶆瘮姣旇緝鍧囪　鐨勭兢钀姐€?
### ID4锛氬浐瀹氭瘮渚嬬粍鎴?
閰嶇疆锛?
```yaml
objective:
  scenario_id: 4
  composition_ratio: [1, 2, 1]
```

鐢ㄩ€旓細

- 鎯虫寚瀹氱兢钀戒腑涓嶅悓鑿屾牚鐨?biomass 姣斾緥銆?
娉ㄦ剰锛?
- `composition_ratio` 鐨勯暱搴﹀繀椤诲拰褰撳墠缁勫悎閲岀殑鑿屾牚鏁伴噺鍖归厤銆?- 濡傛灉涓嶅啓 `composition_ratio`锛屽綋鍓嶇▼搴忎細閫€鍥炲埌榛樿绛夋瘮渚嬨€?
瀵逛簬鍒濆鑰咃紝濡傛灉涓嶇‘瀹氭瘮渚嬫€庝箞鍐欙紝寤鸿鍏堢敤 ID3銆?
### ID5锛氬吋椤剧敓闀垮拰 N2O 娑堣€?
閰嶇疆锛?
```yaml
objective:
  scenario_id: 5
  growth_fraction: 0.9
```

鐢ㄩ€旓細

- 鍏堜繚璇佺兢钀借嚦灏戣揪鍒版渶澶х敓闀块噺鐨?90%銆?- 鍐嶅湪杩欎釜鍩虹涓婂敖閲忔彁楂?N2O 鎽勫彇銆?
鍚箟锛?
```text
growth_fraction: 0.9
```

琛ㄧず淇濈暀 90% 鏈€澶х敓闀胯兘鍔涖€?
濡傛灉褰撳墠妯″瀷鎴栧煿鍏诲熀涓嬫病鏈?N2O 鎽勫彇鑳藉姏锛孖D5 鐨勭粨鏋滃彲鑳藉拰 ID1 涓€鏍枫€傝繖涓嶆槸閿欒锛岃€屾槸璇存槑绋嬪簭娌℃湁鎵惧埌鍙互鎻愰珮鐨?N2O uptake銆?
## 7. biomass_reactions.tsv 鎬庝箞鍐?
鏂囦欢锛?
```text
config/biomass_reactions.tsv
```

鏍煎紡锛?
```text
strain	biomass_rxn
005	Growth
016	Growth
020	Growth
E10	Growth
ER45	Growth
```

绗竴鍒楁槸鑿屾牚鍚嶏紝涔熷氨鏄ā鍨嬫枃浠跺悕鍘绘帀鎵╁睍鍚嶃€?
绗簩鍒楁槸妯″瀷閲岀殑 biomass reaction ID銆?
濡傛灉浣犵殑妯″瀷 biomass 鍙嶅簲鍙細

```text
BIOMASS_Ecoli_core_w_GAM
```

閭ｅ氨鍐欙細

```text
strainA	BIOMASS_Ecoli_core_w_GAM
```

## 8. medium.tsv 鎬庝箞鍐?
鏂囦欢锛?
```text
media/medium.tsv
```

甯歌鍒楀寘鎷?exchange reaction銆佷笅鐣屽拰涓婄晫銆傚叿浣撲互褰撳墠鏂囦欢琛ㄥご涓哄噯銆?
COBRA 绾﹀畾锛?
- 璐熸暟涓嬬晫琛ㄧず鍏佽鎽勫彇銆?- 0 琛ㄧず涓嶅厑璁告憚鍙栥€?- 姝ｆ暟閫氶噺閫氬父琛ㄧず鍒嗘硨銆?
渚嬪锛?
```text
EX_no3_e	-10	1000
```

琛ㄧず鍏佽纭濋吀鐩愭憚鍙栵紝鏈€澶ф憚鍙栭€熺巼涓?10銆?
濡傛灉浣犲笇鏈涙ā鍨嬭兘鎽勫彇 N2O锛岄渶瑕佸煿鍏诲熀鎴栦氦鎹㈢害鏉熶腑鍏佽 N2O exchange 鍏锋湁璐熶笅鐣屻€?
## 9. metabolite_aliases.tsv 鏄粈涔?
鏂囦欢锛?
```text
config/metabolite_aliases.tsv
```

瀹冨憡璇夌▼搴忓摢浜?ID 浠ｈ〃纭濋吀鐩愩€佷簹纭濋吀鐩愩€丯2O 绛夌洰鏍囦唬璋㈢墿銆?
渚嬪锛?
```text
canonical_id	alias	category
n2o	n2o_e	nitrous_oxide
n2o	EX_n2o_e	nitrous_oxide
```

濡傛灉浣犵殑妯″瀷閲?N2O 浜ゆ崲鍙嶅簲涓嶆槸 `EX_n2o_e`锛岄渶瑕佹妸瀵瑰簲 ID 鍔犲埌杩欎釜鏂囦欢閲屻€?
## 10. 杈撳嚭鏂囦欢鎬庝箞鐪?
杩愯缁撴潫鍚庯紝缁撴灉鏂囦欢澶归噷甯歌鏂囦欢鍖呮嫭锛?
```text
community_summary.tsv
community_summary.csv
single_strain_results.tsv
model_validation.tsv
reaction_mapping.tsv
metabolite_mapping.tsv
failed_combinations.tsv
run.log
```

### 10.1 community_summary.tsv

杩欐槸鏈€閲嶈鐨勭粨鏋滆〃銆?
甯歌鍒楋細

- `combination_id`锛氱粍鍚堝悕绉般€?- `community_size`锛氱粍鍚堥噷鏈夊嚑涓弻鏍€?- `strain_names`锛氱粍鍚堜腑鐨勮弻鏍€?- `feasible`锛氭槸鍚﹀彲琛岋紝1 琛ㄧず鍙銆?- `objective_mode`锛氫娇鐢ㄧ殑鐩爣妯″紡銆?- `total_biomass`锛氭€荤敓鐗╅噺銆?- `strain_biomass_*`锛氭瘡涓弻鏍殑鐢熺墿閲忋€?- `nitrate_uptake`锛氱閰哥洂鎽勫彇銆?- `nitrite_uptake`锛氫簹纭濋吀鐩愭憚鍙栥€?- `nitrite_secretion`锛氫簹纭濋吀鐩愬垎娉屻€?- `no_uptake`锛氫竴姘у寲姘憚鍙栥€?- `no_secretion`锛氫竴姘у寲姘垎娉屻€?- `n2o_uptake`锛氭哀鍖栦簹姘憚鍙栥€?- `n2o_secretion`锛氭哀鍖栦簹姘垎娉屻€?- `n2o_net_flux`锛歂2O 鍑€浜ゆ崲閫氶噺銆?- `n2_secretion`锛氭爱姘斾骇鐢熴€?- `runtime_seconds`锛氳缁勫悎杩愯鏃堕棿銆?
### 10.2 failed_combinations.tsv

濡傛灉鏌愪簺缁勫悎澶辫触锛屼細鍐欏湪杩欓噷銆?
甯歌閿欒鍜屽惈涔夛細

- `Default LP solver not selected`锛氭病鏈夊垵濮嬪寲 COBRA 姹傝В鍣ㄣ€?- `Unknown target_strain`锛氱洰鏍囪弻鍚嶅瓧鍜屾ā鍨嬫枃浠跺悕涓嶄竴鑷淬€?- `Objective reaction not found`锛歜iomass reaction ID 鍐欓敊銆?- `Incorrect size(model.sense)` 鎴?`Incorrect size(model.rhs)`锛氭ā鍨嬬害鏉熷瓧娈电淮搴﹀紓甯革紝褰撳墠鐗堟湰宸查拡瀵?ID3/ID4 淇銆?
## 11. 甯歌浠诲姟鎬庝箞鍋?
### 11.1 鍙湅鐢熼暱鏈€濂界殑缁勫悎

```yaml
objective:
  scenario_id: 1
```

杩愯鍚庢煡鐪嬶細

```text
community_summary.tsv
```

鎸?`total_biomass` 浠庡ぇ鍒板皬鎺掑簭銆?
### 11.2 鐪嬪摢涓粍鍚堟渶鏈夊埄浜?E10 鐢熼暱

```yaml
objective:
  scenario_id: 2
  target_strain: E10
```

杩愯鍚庣湅锛?
```text
strain_biomass_E10
```

濡傛灉鍏ㄦ槸 0锛岃鏄庡綋鍓嶅煿鍏诲熀鍜屾ā鍨嬩笅 E10 娌℃湁鍙娴嬬敓闀裤€?
### 11.3 鐪嬬瓑姣斾緥缇よ惤

```yaml
objective:
  scenario_id: 3
```

杩愯鍚庣湅锛?
```text
total_biomass
minimum_growth_satisfied
```

### 11.4 鐪?N2O 娑堣€楄兘鍔?
```yaml
objective:
  scenario_id: 5
  growth_fraction: 0.9
```

杩愯鍚庣湅锛?
```text
n2o_uptake
n2o_net_flux
total_biomass
```

濡傛灉 `n2o_uptake` 鍏ㄦ槸 0锛岃鏄庡綋鍓嶆ā鍨嬪拰鍩瑰吇鍩烘病鏈変骇鐢熷彲鐢ㄧ殑 N2O 鎽勫彇閫氶噺銆?
### 11.5 姣忔杩愯淇濆瓨鍒颁笉鍚屾枃浠跺す

淇敼锛?
```yaml
project:
  output_dir: results_ID5_growth_n2o
```

涓嶅悓浠诲姟寤鸿鐢ㄤ笉鍚屾枃浠跺す锛屼緥濡傦細

```text
results_ID1_growth
results_ID2_E10
results_ID3_equal_ratio
results_ID5_n2o
```

## 12. 鎹㈣嚜宸辩殑鑿屾牚妯″瀷

姝ラ锛?
1. 鎶婃棫 XML 妯″瀷绉昏蛋鎴栧浠姐€?2. 鎶婃柊妯″瀷鏀惧埌 SynComDesign 椤圭洰鐩綍鎴栦綘閰嶇疆鐨勬ā鍨嬬洰褰曘€?3. 淇敼 `models.directory` 鍜?`models.file_pattern`銆?4. 淇敼 `config/biomass_reactions.tsv`銆?5. 妫€鏌?`config/metabolite_aliases.tsv` 鏄惁鍖呭惈鐩爣浠ｈ阿鐗?ID銆?6. 妫€鏌?`media/medium.tsv` 鏄惁閫傚悎浣犵殑妯″瀷銆?7. 杩愯 `runSynComDesign`銆?
## 13. 鎹㈠煿鍏诲熀

鎺ㄨ崘涓嶈鐩存帴瑕嗙洊鏃у煿鍏诲熀锛岃€屾槸澶嶅埗涓€浠斤細

```text
media/medium.tsv
```

鏀瑰悕涓猴細

```text
config/medium_new_condition.tsv
```

鐒跺悗鍦ㄩ厤缃噷鏀癸細

```yaml
medium:
  file: config/medium_new_condition.tsv
```

## 14. 缁撴灉鍏ㄥけ璐ユ€庝箞鍔?
鍏堟墦寮€锛?
```text
results/failed_combinations.tsv
```

鎸夐敊璇被鍨嬫帓鏌ャ€?
### 14.1 娌℃湁閫夋嫨 LP 姹傝В鍣?
鍦?MATLAB 閲岃繍琛岋細

```matlab
initCobraToolbox(false);
changeCobraSolver('gurobi', 'LP');
```

鐒跺悗閲嶆柊杩愯銆?
### 14.2 biomass reaction 鎵句笉鍒?
妫€鏌ワ細

```text
config/biomass_reactions.tsv
```

纭绗簩鍒楃殑 reaction ID 鍦ㄦā鍨嬮噷鐪熷疄瀛樺湪銆?
### 14.3 鐩爣鑿岀敓鐗╅噺涓?0

鍙兘鍘熷洜锛?
- 鐩爣鑿屽湪褰撳墠鍩瑰吇鍩轰笅涓嶈兘鐢熼暱銆?- biomass reaction ID 閿欎簡銆?- 鐩爣鑿岀己灏戝繀瑕佽惀鍏荤墿浜ゆ崲鍙嶅簲銆?- 鍩瑰吇鍩哄叧闂簡鏌愪釜蹇呴』鎽勫彇鐨勮惀鍏荤墿銆?
鍙互鍏堢敤 ID1 鐪嬭鑿屽崟鐙槸鍚﹁兘鐢熼暱銆?
### 14.4 N2O uptake 鍏ㄦ槸 0

鍙兘鍘熷洜锛?
- 妯″瀷娌℃湁 N2O exchange reaction銆?- `metabolite_aliases.tsv` 娌″啓瀵?N2O ID銆?- 鍩瑰吇鍩烘病鏈夊紑鏀?N2O 鎽勫彇銆?- 妯″瀷娌℃湁鍒╃敤 N2O 鐨勪唬璋㈣矾寰勩€?
## 15. 鎺ㄨ崘鐨勬棩甯镐娇鐢ㄦ祦绋?
1. 纭妯″瀷鏂囦欢銆?2. 纭 biomass reaction 鏂囦欢銆?3. 纭鍩瑰吇鍩烘枃浠躲€?4. 璁剧疆 `scenario_id`銆?5. 璁剧疆 `output_dir`銆?6. 鍦?MATLAB 涓繍琛屻€?7. 鏌ョ湅 `community_summary.tsv`銆?8. 鏌ョ湅 `failed_combinations.tsv`銆?9. 淇濆瓨閰嶇疆鏂囦欢鍜岀粨鏋滄枃浠跺す锛屾柟渚夸互鍚庡鐜般€?
## 16. 鏈€灏忓彲澶嶇幇瀹為獙璁板綍

姣忔姝ｅ紡鍒嗘瀽寤鸿璁板綍锛?
- 浣跨敤鐨勬ā鍨嬫枃浠躲€?- 浣跨敤鐨勫煿鍏诲熀鏂囦欢銆?- 浣跨敤鐨?`syncomdesign_config.yml`銆?- 浣跨敤鐨勭洰鏍?ID銆?- 浣跨敤鐨?MATLAB 鐗堟湰銆?- 浣跨敤鐨?COBRA Toolbox 鐗堟湰銆?- 浣跨敤鐨勬眰瑙ｅ櫒銆?- 杈撳嚭缁撴灉鏂囦欢澶广€?
杩欐牱鍒汉鎵嶈兘澶嶇幇浣犵殑缁撴灉銆?
## 17. 閲嶈澹版槑

SynComDesign 鏄湪鍘?SuperCC 宸ヤ綔娴佹€濇兂鍜屼唬鐮佸熀纭€涓婁慨鏀广€侀€傞厤鍜屾墿灞曞緱鍒扮殑椤圭洰銆備娇鐢ㄦ垨鍙戝竷鍓嶏紝搴斾繚鐣欏鍘?SuperCC 璁烘枃鍜?GitHub 浠撳簱鐨勫紩鐢ㄨ鏄庛€?
鍘熷椤圭洰锛?
```text
https://github.com/ruanzhepu/superCC
```

鍘熷璁烘枃锛?
```text
Ruan, Z., Chen, K., Cao, W. et al. Engineering natural microbiomes toward
enhanced bioremediation by microbiome modeling. Nature Communications 15, 4694
(2024). https://doi.org/10.1038/s41467-024-49098-z
```

鏈墜鍐屼笉鏄硶寰嬫剰瑙併€傝嫢璁″垝鍏紑鍙戝竷锛岃鍏堢‘璁ゅ師椤圭洰鍜岀涓夋柟渚濊禆鐨勮鍙姹傘€?
