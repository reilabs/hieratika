use crate::rtstate::RTState;
use crate::alu::umul_with_overflow::umul_with_overflow;

pub fn __llvm_umul_with_overflow_l_l_Slcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    umul_with_overflow::<u64>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_umul_with_overflow_l_l_Slcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 244] = [
        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 12729659705565803457, rhs: 16266461329073073793, expected: (2843438713774031425, true)},
        TestCaseTwoArgsTwoExpected{lhs: 259602061817146517, rhs: 16878943921534088254, expected: (449945116127825942, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6780786297189099215, rhs: 260219329428087017, expected: (7696733239812665959, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7322093391218725306, rhs: 17228078529936338404, expected: (4698411682875014056, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4505123694091770953, rhs: 5287592594832220385, expected: (15534756259455482921, true)},
        TestCaseTwoArgsTwoExpected{lhs: 892200287175709603, rhs: 3054016948755274247, expected: (9686122232401663861, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7237704572902429850, rhs: 2082013536802144573, expected: (10170073620083327666, true)},
        TestCaseTwoArgsTwoExpected{lhs: 995702225286627863, rhs: 15058747244770794974, expected: (11165371533018852082, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5650948764789316964, rhs: 16404632186196284110, expected: (14581533353272913528, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10689814702873136330, rhs: 10859211718272950669, expected: (6316404109087757634, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13572716222414688919, rhs: 9416236862572074815, expected: (167970316972106793, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6383000526013157044, rhs: 13138464299957754589, expected: (8141802347800770916, true)},
        TestCaseTwoArgsTwoExpected{lhs: 403693739584189444, rhs: 13398146517612425751, expected: (3014518172679910492, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14179107606438995749, rhs: 8565247778924954012, expected: (14242674976719142796, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7415954974894275075, rhs: 11084870459137652131, expected: (1299975224946249449, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14259565527034694159, rhs: 8936113595537090259, expected: (14561032481656063069, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6350071726416456511, rhs: 16373544985794441481, expected: (7554908475265684535, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11780303788328797872, rhs: 3751127242607652079, expected: (632591929342017104, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10321211679675873506, rhs: 12728418426620958355, expected: (9516004248604792262, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13430034442422992447, rhs: 8696767563546315807, expected: (4322262295474290081, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10443331359671055373, rhs: 13336724991555239901, expected: (10616610958304420409, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7397751365878370612, rhs: 322696885604910986, expected: (18418519980124811784, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10837857087816480941, rhs: 2223938039654278494, expected: (17779541437023195270, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3237366732416012259, rhs: 12912927595687205961, expected: (11897272058924817339, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7021696000060878546, rhs: 1169834623292169045, expected: (9252162776020545978, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12597472835006994438, rhs: 8317462397412794214, expected: (8305697414599855204, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14887171780873633864, rhs: 3403074505981034414, expected: (2185519944336763120, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6177987189063350214, rhs: 16872369174348596246, expected: (9753493304155005700, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1134474786239059168, rhs: 16183833686982545266, expected: (7128556781867330496, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3512557082633083798, rhs: 16753812643322638068, expected: (1187209487317614328, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16930703427706313974, rhs: 11251541491509990113, expected: (17653715418282459190, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9326546278997525597, rhs: 12726225777414599346, expected: (14426965744054858410, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8919838579603043859, rhs: 14546169841562629119, expected: (13872195056722535917, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8321572267752281411, rhs: 7636971029404698958, expected: (3181521554758407530, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3377473795072890377, rhs: 17624843056093576678, expected: (956246850443571478, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4682607772597090202, rhs: 15918821007271023697, expected: (11618739959703396282, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2371980500169648747, rhs: 3577280921290554733, expected: (12397798332706082447, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18271560750953892367, rhs: 17878335752927073511, expected: (2917517068333776777, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16249854352233091509, rhs: 1989001487840829470, expected: (14722879043832967990, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6217572106359818493, rhs: 14425221211705959908, expected: (10878073646318899796, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13875484234990581891, rhs: 6474164272969699848, expected: (14828064784027204120, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12045334093571206466, rhs: 15150434453710763070, expected: (446959210247806460, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4807410570330361499, rhs: 9026187141788780818, expected: (10542624608922647014, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15124305906274718429, rhs: 12565631851785303753, expected: (12422665576937893253, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1720651404576317658, rhs: 9391193059958417789, expected: (5957190528445101170, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7432151401989494596, rhs: 10092859809200998626, expected: (4455171137015458312, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11917206793403691320, rhs: 5190750936631941960, expected: (15498150295338008512, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5231950496968633712, rhs: 12939601550471738332, expected: (8761433379545766976, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11178902371047219641, rhs: 15792967095069543602, expected: (7008747698664414882, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1877648581621991845, rhs: 3810058614401128650, expected: (5704862529581503538, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10121065665497425247, rhs: 11960336428885654037, expected: (17012792850463282891, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9877443629557973740, rhs: 16111838457492628426, expected: (7911940895451288120, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18381498303584955965, rhs: 1230387555566289405, expected: (12876903529217142601, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13222511406001858900, rhs: 17640572154450181463, expected: (2596327483548995468, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11135062773687913993, rhs: 10842105836714815059, expected: (15768749779158264555, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15690877534965318221, rhs: 17560716506090452185, expected: (15258890820973188933, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7566124990920851745, rhs: 12600626987250742506, expected: (12462246649341246506, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10781803693281385412, rhs: 1796500173273546425, expected: (9930556034874312868, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9067406082980271928, rhs: 5587124410818042216, expected: (7337429388927428288, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8413873071448535731, rhs: 14479341548559268889, expected: (4150314708395501435, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7917819871321579995, rhs: 16417207616086592938, expected: (7302338605940038254, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6149125428125773251, rhs: 5179943938581571845, expected: (7580910976112107471, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12631397808524193469, rhs: 4056334257214933154, expected: (6667103783620721562, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18078777265234814688, rhs: 4221513797243734355, expected: (2187355681847376544, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17971648911273749328, rhs: 15698851327892825005, expected: (5532320705890219280, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15384761296645618319, rhs: 2133682315219820375, expected: (12755816917974005657, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5192652508018085303, rhs: 14146547744200776166, expected: (11049636491852345706, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15227338202886896730, rhs: 1560621195158097744, expected: (14321236318630715936, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2828126123435138790, rhs: 3941317431944184562, expected: (4858470433761984876, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6576135709160190558, rhs: 11575311851310379259, expected: (6234360499172246058, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18426428825670946866, rhs: 2111218790485998971, expected: (17368026393032471046, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8838193133894670773, rhs: 10548619880877083846, expected: (605629970559901182, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5832958556575048717, rhs: 1485117666685089246, expected: (8955101968875435078, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10109085876923047439, rhs: 10727599488065907921, expected: (5858303454453767743, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1146473593898020111, rhs: 14431244171753222933, expected: (17609024357444284219, true)},
        TestCaseTwoArgsTwoExpected{lhs: 481212515371659471, rhs: 6681396551531155730, expected: (2849901251882806670, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2322059849753447468, rhs: 6344483561126850605, expected: (9336291008511255484, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6748922167134554955, rhs: 15054427794552349366, expected: (15510994033902796114, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5893023302938224068, rhs: 8982288605706232957, expected: (703258422649438388, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8498833167900669288, rhs: 5992980079342291253, expected: (14837764252986865288, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13225054811894548865, rhs: 7697169835609777397, expected: (7448543648194493557, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14156711836482608404, rhs: 15378229706289391878, expected: (10382598596336476792, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15871848977854753569, rhs: 77237784584242928, expected: (7726851437684651248, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3831337523195968345, rhs: 7533758099688826107, expected: (13083870373885375555, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16812409483951927363, rhs: 17887012281746303527, expected: (8061101015150106677, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2266839677298921152, rhs: 15787554190380182564, expected: (11129451001082942208, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9753770964388151798, rhs: 4226922357663019934, expected: (14919462303166052308, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10625079507328445872, rhs: 1137211899884375037, expected: (6785394271587645168, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11641210099933363684, rhs: 12927688697254930879, expected: (8214557472452587804, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11730550336315889094, rhs: 15364021463183265583, expected: (6141290034120628570, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2844872498810941679, rhs: 11383557668958098311, expected: (2035975921361914633, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5278110648036204028, rhs: 17777003925699507, expected: (3595145183554407220, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7837457375897175446, rhs: 1209052344577468187, expected: (7712187809345351890, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17563828117256659518, rhs: 7293079196316149070, expected: (8644561358977230052, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4051400011403217152, rhs: 5635851130145882693, expected: (2799536321860152576, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15086260452304296903, rhs: 15052791127553545943, expected: (7593226364365336097, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5983021472773260952, rhs: 10906610939271791277, expected: (2487012455365862584, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9144946893595219060, rhs: 3472409073634800750, expected: (14554903025449785816, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12107897299185933572, rhs: 1544162200633676832, expected: (16357547743723647104, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15247534456829630244, rhs: 16560656625142075793, expected: (12304705126082166628, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6770753079973605375, rhs: 5280689810200432545, expected: (17246515990228230239, true)},
        TestCaseTwoArgsTwoExpected{lhs: 847846741284487298, rhs: 2019350646589279163, expected: (5988344484982387958, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9787047640053192498, rhs: 4515644490346747466, expected: (17608998001007100020, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18034567809555303734, rhs: 10943633729291625736, expected: (6455059076785584048, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15714729385501479696, rhs: 3390636269792526508, expected: (13405982116151545536, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11853671599715862866, rhs: 4395593895500839211, expected: (18438379402992816838, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5783733783743418860, rhs: 17132257891079419751, expected: (8267043050128681460, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15679025177811871334, rhs: 4994159008998241736, expected: (13438018880465214896, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11773395606303530747, rhs: 2409147486319374014, expected: (8759303014269343818, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18202414848429809870, rhs: 5979456975842720827, expected: (2711440018445342586, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10672055482359637231, rhs: 10651479765015049967, expected: (1467483253610325281, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12532791846710780246, rhs: 3145561193507259600, expected: (9481627934223396320, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4356999529426193153, rhs: 3084656422021618356, expected: (4212780257544476340, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10232651560231001733, rhs: 13982062813023707247, expected: (9808635572411014059, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9574595165538663253, rhs: 4757474559203604123, expected: (17859378816362748535, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10168136285645161578, rhs: 11115906405025839203, expected: (5538070249972990, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5870334018031463767, rhs: 13556600823527422809, expected: (1138994425092395071, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1482560730481565362, rhs: 12440208867032681471, expected: (10855653898285463886, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14425091048965338338, rhs: 17958423655046118426, expected: (17912543217311504116, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6807416128349767233, rhs: 3838338500534245836, expected: (14421817586537714892, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10117813033541550313, rhs: 6582215362242099416, expected: (17238766049032453272, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16972841944646786327, rhs: 4939719807609560473, expected: (14004047059478199743, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15725919242275946940, rhs: 12060612326943126894, expected: (14901873371915922120, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2647649274162374956, rhs: 9104022266211579604, expected: (3881896970182353008, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5834547050928330923, rhs: 7642059438564565201, expected: (11290451667042796443, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11728830867515496998, rhs: 7004498976747160712, expected: (10068966492627565616, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14532403191077904970, rhs: 13929911332362167530, expected: (1601979944823275428, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4434891416965078848, rhs: 17809126045499625464, expected: (6253509002433725952, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6060417789452330180, rhs: 2912703647981511575, expected: (6859636880285957020, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7193294419753390183, rhs: 1135098996775103209, expected: (15827957281822774207, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8239084921636208778, rhs: 10635387139705635010, expected: (952763199279458452, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9282400506760621602, rhs: 3143272680163836260, expected: (5716646357491197768, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16779530770709306279, rhs: 12604794290326307129, expected: (2902659312138293039, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2315165887321740957, rhs: 8972678837654423618, expected: (10668880966664273018, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2571774295105700030, rhs: 6746732473249692423, expected: (14948387985794453298, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14149294895865009011, rhs: 6313132208485096976, expected: (693766139642835248, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7056945888992053323, rhs: 14061140986707004241, expected: (567389355624356027, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6202428769019601909, rhs: 12574905305744199694, expected: (8047075428670637926, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2365325153222814610, rhs: 284337883120245305, expected: (15696168369462167426, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14217331926483742269, rhs: 1868283073062044860, expected: (14971117246072219852, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9521504060398649651, rhs: 12730880055630221325, expected: (15278613021019062167, true)},
        TestCaseTwoArgsTwoExpected{lhs: 51467777362113038, rhs: 10403651054560526405, expected: (8777223511590567366, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10364364876694042601, rhs: 2511174564555628884, expected: (6905353993598329204, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3624286398194849647, rhs: 2331839703990619410, expected: (7574071871686641870, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3733073181814046190, rhs: 9367409812188028923, expected: (6523822041171036762, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18168733277089495898, rhs: 8810685471583588672, expected: (8250984349257453696, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9216063797730782285, rhs: 13055303099568403410, expected: (18022173482874514986, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5848608505129150552, rhs: 10078074980367768781, expected: (17792060867304418936, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12193980322249986565, rhs: 16225592531300556270, expected: (14731448887830598054, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1756669798127790832, rhs: 9939786870592966614, expected: (16263476563166459040, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16630458694027979630, rhs: 8401122304357596234, expected: (2271886836497765836, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8739733612218841122, rhs: 18382413147485016729, expected: (13622454810413576274, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2904423490777159342, rhs: 13214326204822463160, expected: (4067033476257769744, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3762448166384218115, rhs: 5600278740267182879, expected: (9572272468457148765, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15249355728070401215, rhs: 17521817542242844665, expected: (11421331812631819975, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11973897757581152946, rhs: 15490411276883016348, expected: (4386247219360544888, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15160648226825586134, rhs: 11318599676736529754, expected: (3343965316385864508, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18137510815542233946, rhs: 15332238106633300216, expected: (4378744767473553200, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7415880358274394765, rhs: 2110867459874282835, expected: (2122096837708661943, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8506252004865266246, rhs: 5173588698431325523, expected: (12062137961635809970, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10930233196343080559, rhs: 9569318284006973881, expected: (1605162192636929335, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2588831968898786262, rhs: 4736512524912051680, expected: (4269077687423994176, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17737266858264363736, rhs: 14190213970585539871, expected: (14318022592070553640, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17873822345477261418, rhs: 3610019309569120586, expected: (12889957874081450148, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2301779797240032095, rhs: 11077532984141419715, expected: (216984639828718941, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3880757708291159455, rhs: 16498994975788430317, expected: (4325424179609669939, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7497735969989362980, rhs: 17345864540592782077, expected: (12201104893767171220, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9059734990078989180, rhs: 2760685242479494553, expected: (12468079392707301660, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4198667153850753054, rhs: 16495371734293047366, expected: (13440807655759640628, true)},
        TestCaseTwoArgsTwoExpected{lhs: 693606824228382765, rhs: 7026692345502828133, expected: (1288075890762983361, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11188000727455045275, rhs: 4210737824103989933, expected: (13479785086247533759, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11136933013937742460, rhs: 10504139524814788777, expected: (6762374397600310236, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8232087497259040699, rhs: 14626537732980878763, expected: (6649299710987694313, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3855466325277927855, rhs: 12290414505347703164, expected: (11043433414462668740, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8638174770101824069, rhs: 8219688511317108048, expected: (5497508886344396432, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3966030240259931762, rhs: 14065489528006425168, expected: (8823676171624273824, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6643901445374216030, rhs: 7687892216819879157, expected: (14160398034214024438, true)},
        TestCaseTwoArgsTwoExpected{lhs: 670168401391135658, rhs: 15591252654108179569, expected: (9911007864482733578, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8482034618961471304, rhs: 10698534915081996829, expected: (14258921198479917864, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13241186841825982280, rhs: 11196926983117161532, expected: (11291628159750903008, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7543526690706555108, rhs: 248925718917384082, expected: (5686581137985551880, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14732092291668054949, rhs: 17772684478837080275, expected: (9923059950860431615, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5734211295004837621, rhs: 6946674897874615746, expected: (71729036543551146, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17148300406205641748, rhs: 7392944446201909268, expected: (11450338971380830608, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4089919767040014518, rhs: 9903096319550974745, expected: (12763585406600616902, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7867189916480413279, rhs: 12917966034292752310, expected: (9683612968969533578, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11736552780096399018, rhs: 2652156983083825631, expected: (14342882286093682710, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16796350896872148003, rhs: 10628399029069961382, expected: (14840164011578123954, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4959698122591479083, rhs: 9583965259359511638, expected: (13411932995583199346, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12948489411084692454, rhs: 378486167034605608, expected: (6516869443908008944, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7116264980249980112, rhs: 6344851222447259640, expected: (1438364831935535488, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8161773733309105991, rhs: 17002944026152807899, expected: (8505645977657537725, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16969059388258976467, rhs: 13884555659573672489, expected: (8029517372512551371, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6603136982732177617, rhs: 15892767296380139240, expected: (18162558651551683432, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2444860480814022676, rhs: 3351703547208573431, expected: (13903027185995818828, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9691713616016285408, rhs: 18084324498286060649, expected: (4411077875317844448, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10487008393656431677, rhs: 326397150253933470, expected: (15253723411570939046, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14452861884118242832, rhs: 14244401423086977647, expected: (15942038588046651632, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12206448995109260580, rhs: 10109006653227043433, expected: (3217899051309992900, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13499258356313721508, rhs: 7321574347783340371, expected: (13377397152947541804, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10582052267703978397, rhs: 1093242008611384860, expected: (4554004911278654252, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9778171454657034009, rhs: 11450032622955964516, expected: (14199107269662797252, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4811000214454601228, rhs: 13067487931444886962, expected: (15539888871887343704, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11252138826380985732, rhs: 11486849111117822527, expected: (8961801966514635644, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2122029271898818241, rhs: 17107807722902436393, expected: (2802796175124057833, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3183099571366352944, rhs: 2619140569218639820, expected: (10995489336349005376, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5156870166323563111, rhs: 15502601969311915003, expected: (6273210897986162685, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2112950070827935394, rhs: 10365839724124616088, expected: (3823419799992105520, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10166167256644229549, rhs: 14281509811733188060, expected: (11068914753501895084, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16529052336475499352, rhs: 3426583079031530358, expected: (14107599814151406224, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12348758431616100452, rhs: 10437258771771843611, expected: (12817149118552740492, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13216589570661728556, rhs: 4395349036434885375, expected: (6152661764730135252, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8237798287268752158, rhs: 3038425236933803732, expected: (14955350172787308760, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11157114079960443086, rhs: 6102127411419562496, expected: (2672377651690806272, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3064884784103005688, rhs: 7735681222766708531, expected: (918086580494024808, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4673424112811305959, rhs: 6113737754385194149, expected: (7022672796540686307, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6070078287812006062, rhs: 1923747931796844651, expected: (836727598786812090, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15378953268302402260, rhs: 11246619568431305112, expected: (9239498793960948192, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2340191985679289431, rhs: 6993522655949935090, expected: (5887004419822924094, true)},
        TestCaseTwoArgsTwoExpected{lhs: 51337378818325784, rhs: 2389715142792502444, expected: (12894142412702395424, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4452143063164268787, rhs: 16551111640698755123, expected: (11154549457480321129, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14017008743897107453, rhs: 10067150571617260894, expected: (4710149742289889254, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16910443733463611151, rhs: 8181568679485702596, expected: (14395945110557439612, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3029645401801711633, rhs: 14069088987286738822, expected: (4770679810617757670, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13826534270655710857, rhs: 16368520026261757608, expected: (16916206046716975080, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7363772222307777916, rhs: 6194110504531879444, expected: (18145627044016567728, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9099605948143717809, rhs: 11012024548083497708, expected: (3302803126452451628, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4900902236485542069, rhs: 15180193732236603034, expected: (15873758796714767074, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8599656607232301405, rhs: 8545199569180881187, expected: (3185585517766902967, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16296184340139620656, rhs: 13900334362535222000, expected: (3517639623618624768, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15732425546113076291, rhs: 11530074268452445469, expected: (8929108858973977239, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16715230539123489548, rhs: 14824102067745399598, expected: (11404157329004216360, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11590835830304603619, rhs: 15389386254139029643, expected: (11204151790337802817, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2136985642090632452, rhs: 3183531477921425635, expected: (10475626584294179468, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8818760672414405713, rhs: 3376239544886978721, expected: (9413888719496982257, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14109954837546396073, rhs: 11056396638570629802, expected: (7785231791016313914, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1129361242566337936, rhs: 13202874891750574027, expected: (1675821555694188848, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3477696351329459789, rhs: 5092480168754563323, expected: (10619963650912247167, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10802320551379730588, rhs: 14083571871829921430, expected: (12340227223059751784, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10048473075764225090, rhs: 17376010449653027370, expected: (2065539259533137620, true)},

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 18446744073709551615, rhs: 18446744073709551615, expected: (1, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18446744073709551615, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 18446744073709551615, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
    ];

    #[test]
    fn test_i64() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_umul_with_overflow_l_l_Slcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
