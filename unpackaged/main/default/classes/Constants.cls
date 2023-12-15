public class Constants {

    public static final Set<String> PREPS_CONJ_CONT = new Set<String>{
        'DA', 'DAS', 'DE', 'DEL', 'DER', 'DI', 'DIE',
        'DD', 'EL', 'LA', 'LOS', 'LAS', 'LE', 'LES',
        'MAC', 'MC', 'VAN', 'VON', 'Y'
    };

    public static final Set<String> SIGNOS_ENE = new Set<String>{
        '/', '-', '.', 'Ñ'
    };

    public static final Set<String> VOWEL_SET = new Set<String>{
        'A', 'E', 'I', 'O', 'U'
    };

    public static final Set<String> SPECIAL_SIGN_SET = new Set<String>{
        '/', '-', '.'
    };

    public static final Set<String> ILLEGAL_NAME_SET = new Set<String>{
        'MARIA', 'MA.', 'MA', 'JOSE', 'J', 'J.'
    };

    public static final Map<String,String> INCONVENIENT_WORDS = new Map<String,String>{
        'BACA'=>'BXCA',
        'BAKA'=>'BXKA',
        'BUEI'=>'BXEI',
        'BUEY'=>'BXEY',
        'CACA'=>'CXCA',
        'CACO'=>'CXCO',
        'CAGA'=>'CXGA',
        'CAGO'=>'CXGO',
        'CAKA'=>'CXKA',
        'CAKO'=>'CXKO',
        'COGE'=>'CXGE',
        'COGI'=>'CXGI',
        'COJA'=>'CXJA',
        'COJE'=>'CXJE',
        'COJI'=>'CXJI',
        'COJO'=>'CXJO',
        'COLA'=>'CXLA',
        'CULO'=>'CXLO',
        'FALO'=>'FXLO',
        'FETO'=>'FXTO',
        'GETA'=>'GXTA',
        'GUEI'=>'GXEI',
        'GUEY'=>'GXEY',
        'JETA'=>'JXTA',
        'JOTO'=>'JXTO',
        'KACA'=>'KXCA',
        'KACO'=>'KXCO',
        'KAGA'=>'KXGA',
        'KAGO'=>'KXGO',
        'KAKA'=>'KXKA',
        'KAKO'=>'KXKO',
        'KOGE'=>'KXGE',
        'KOGI'=>'KXGI',
        'KOJA'=>'KXJA',
        'KOJE'=>'KXJE',
        'KOJI'=>'KXJI',
        'KOJO'=>'KXJO',
        'KOLA'=>'KXLA',
        'KULO'=>'KXLO',
        'LILO'=>'LXLO',
        'LOCA'=>'LXCA',
        'LOCO'=>'LXCO',
        'LOKA'=>'LXKA',
        'LOKO'=>'LXKO',
        'MAME'=>'MXME',
        'MAMO'=>'MXMO',
        'MEAR'=>'MXAR',
        'MEAS'=>'MXAS',
        'MEON'=>'MXON',
        'MIAR'=>'MXAR',
        'MION'=>'MXON',
        'MOCO'=>'MXCO',
        'MOKO'=>'MXKO',
        'MULA'=>'MXLA',
        'MULO'=>'MXLO',
        'NACA'=>'NXCA',
        'NACO'=>'NXCO',
        'PEDA'=>'PXDA',
        'PEDO'=>'PXDO',
        'PENE'=>'PXNE',
        'PIPI'=>'PXPI',
        'PITO'=>'PXTO',
        'POPO'=>'PXPO',
        'PUTA'=>'PXTA',
        'PUTO'=>'PXTO',
        'QULO'=>'QXLO',
        'RATA'=>'RXTA',
        'ROBA'=>'RXBA',
        'ROBE'=>'RXBE',
        'ROBO'=>'RXBO',
        'RUIN'=>'RXIN',
        'SENO'=>'SXNO',
        'TETA'=>'TXTA',
        'VACA'=>'VXCA',
        'VAGA'=>'VXGA',
        'VAGO'=>'VXGO',
        'VAKA'=>'VXKA',
        'VUEI'=>'VXEI',
        'VUEY'=>'VXEY',
        'WUEI'=>'WXEI',
        'WUEY'=>'WXEY'
    };

    public static final Map<String,String> STATE_CODE_BY_STATE_NAME = new Map<String,String>{
        'AGUASCALIENTES'=>'AS',
        'BAJA CALIFORNIA'=>'BC',
        'BAJA CALIFORNIA SUR'=>'BS',
        'CAMPECHE'=>'CC',
        'CHIAPAS'=>'CS',
        'CHIHUAHUA'=>'CH',
        'CIUDAD DE MEXICO'=>'DF',
        'COAHUILA'=>'CL',
        'COLIMA'=>'CM',     
        'DURANGO'=>'DG',
        'GUANAJUATO'=>'GT',
        'GUERRERO'=>'GR',
        'HIDALGO'=>'HG',
        'JALISCO'=>'JC',
        'ESTADO DE MEXICO'=>'MC',
        'MICHOACAN'=>'MN',
        'MORELOS'=>'MS',
        'NAYARIT'=>'NT',
        'NUEVO LEON'=>'NL',
        'OAXACA'=>'OC',
        'PUEBLA'=>'PL',
        'QUERETARO'=>'QT',
        'QUINTANA ROO'=>'QR',
        'SAN LUIS POTOSI'=>'SP',
        'SINALOA'=>'SL',
        'SONORA'=>'SR',
        'TABASCO'=>'TC',
        'TAMAULIPAS'=>'TS',
        'TLAXCALA'=>'TL',
        'VERACRUZ'=>'VZ',
        'YUCATAN'=>'YN',
        'ZACATECAS'=>'ZS',
        'EXTRANJERO'=>'NE'
    };

}