import svgPaths from "./svg-9ke3lqxgvp";

function Time() {
  return (
    <div className="absolute h-[54px] left-0 right-[64.25%] top-1/2 translate-y-[-50%]" data-name="Time">
      <p className="absolute css-ew64yg font-['SF_Pro:Semibold',sans-serif] font-[590] inset-[33.96%_35.41%_25.3%_38.26%] leading-[22px] text-[17px] text-black text-center" style={{ fontVariationSettings: "'wdth' 100" }}>
        9:41
      </p>
    </div>
  );
}

function Battery() {
  return (
    <div className="absolute bottom-[33.33%] contents left-[calc(50%+24.8px)] top-[42.59%] translate-x-[-50%]" data-name="Battery">
      <div className="absolute border border-black border-solid bottom-[33.33%] left-[calc(50%+23.64px)] opacity-35 rounded-[4.3px] top-[42.59%] translate-x-[-50%] w-[25px]" data-name="Border" />
      <div className="absolute bottom-[41.01%] left-[calc(50%+37.8px)] top-[51.45%] translate-x-[-50%] w-[1.328px]" data-name="Cap">
        <div className="absolute inset-0" style={{ "--fill-0": "rgba(0, 0, 0, 1)" } as React.CSSProperties}>
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 1.32804 4.07547">
            <path d={svgPaths.p193f1400} fill="var(--fill-0, black)" id="Cap" opacity="0.4" />
          </svg>
        </div>
      </div>
      <div className="absolute bg-black bottom-[37.04%] left-[calc(50%+23.64px)] rounded-[2.5px] top-[46.3%] translate-x-[-50%] w-[21px]" data-name="Capacity" />
    </div>
  );
}

function Levels() {
  return (
    <div className="absolute h-[54px] left-[64.25%] right-0 top-1/2 translate-y-[-50%]" data-name="Levels">
      <Battery />
      <div className="absolute bottom-[33.4%] left-[calc(50%-4.59px)] top-[43.77%] translate-x-[-50%] w-[17.142px]" data-name="Wifi">
        <div className="absolute inset-0" style={{ "--fill-0": "rgba(0, 0, 0, 1)" } as React.CSSProperties}>
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 17.1417 12.3283">
            <path clipRule="evenodd" d={svgPaths.p18b35300} fill="var(--fill-0, black)" fillRule="evenodd" id="Wifi" />
          </svg>
        </div>
      </div>
      <div className="absolute bottom-[33.77%] left-[calc(50%-30.26px)] top-[43.58%] translate-x-[-50%] w-[19.2px]" data-name="Cellular Connection">
        <div className="absolute inset-0" style={{ "--fill-0": "rgba(0, 0, 0, 1)" } as React.CSSProperties}>
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 19.2 12.2264">
            <path clipRule="evenodd" d={svgPaths.p1e09e400} fill="var(--fill-0, black)" fillRule="evenodd" id="Cellular Connection" />
          </svg>
        </div>
      </div>
    </div>
  );
}

function StatusBarIPhone() {
  return (
    <div className="absolute h-[54px] left-0 top-0 w-[430px]" data-name="Status Bar - iPhone">
      <Time />
      <Levels />
    </div>
  );
}

function BackArrowIcon() {
  return (
    <div className="relative size-[24px]" data-name="Back Arrow Icon">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="Back Arrow Icon">
          <path d={svgPaths.p11a25300} id="Vector" stroke="var(--stroke-0, #111111)" strokeLinecap="round" strokeLinejoin="round" strokeMiterlimit="10" strokeWidth="1.92001" />
          <path d="M19.0016 12H5.13837" id="Vector_2" stroke="var(--stroke-0, #111111)" strokeLinecap="round" strokeLinejoin="round" strokeMiterlimit="10" strokeWidth="1.92001" />
          <g id="Vector_3" opacity="0" />
        </g>
      </svg>
    </div>
  );
}

function Arrow() {
  return (
    <div className="absolute content-stretch flex items-start left-[24px] p-[8px] rounded-[8px] top-[74px]" data-name="Arrow">
      <div aria-hidden="true" className="absolute border border-[#e0e0e0] border-solid inset-0 pointer-events-none rounded-[8px]" />
      <div className="flex items-center justify-center relative shrink-0">
        <div className="flex-none scale-y-[-100%]">
          <BackArrowIcon />
        </div>
      </div>
    </div>
  );
}

function HeaderContainer() {
  return (
    <div className="absolute contents left-[24px] top-[74px]" data-name="Header Container">
      <Arrow />
      <p className="absolute css-4hzbpn font-['SF_Pro_Display:Bold',sans-serif] leading-[normal] left-[calc(50%+0.5px)] not-italic text-[18px] text-black text-center top-[83px] translate-x-[-50%] w-[211px]">Delivery Process</p>
    </div>
  );
}

function ColorLight() {
  return <div className="h-[34px] shrink-0 w-[430px]" data-name="Color=Light" />;
}

function IOsStatusBarHomeIndicator() {
  return (
    <div className="absolute bottom-0 content-stretch flex flex-col items-start left-0 w-[430px]" data-name="iOS Status Bar & Home Indicator">
      <ColorLight />
    </div>
  );
}

function Frame() {
  return (
    <div className="content-stretch flex flex-col font-['SF_Pro_Display:Regular',sans-serif] gap-[2px] items-start relative shrink-0 text-[16px] text-[rgba(0,0,0,0.7)] w-full">
      <p className="css-4hzbpn relative shrink-0 w-full">October 17,2024</p>
      <p className="css-4hzbpn relative shrink-0 w-full">Order : #5555444455</p>
    </div>
  );
}

function Frame1() {
  return (
    <div className="absolute content-stretch flex flex-col gap-[10px] items-start leading-[normal] left-[86px] not-italic top-[209px] w-[342px]">
      <p className="css-4hzbpn font-['SF_Pro_Display:Medium',sans-serif] relative shrink-0 text-[18px] text-black w-full">Progress</p>
      <Frame />
    </div>
  );
}

function Frame3() {
  return (
    <div className="content-stretch flex flex-col font-['SF_Pro_Display:Regular',sans-serif] gap-[2px] items-start relative shrink-0 text-[16px] text-[rgba(0,0,0,0.7)] w-full">
      <p className="css-4hzbpn relative shrink-0 w-full">October 24,2024</p>
      <p className="css-4hzbpn relative shrink-0 w-full">Order : #5555444455</p>
    </div>
  );
}

function Frame2() {
  return (
    <div className="absolute content-stretch flex flex-col gap-[10px] items-start leading-[normal] left-[86px] not-italic top-[312px] w-[342px]">
      <p className="css-4hzbpn font-['SF_Pro_Display:Medium',sans-serif] relative shrink-0 text-[18px] text-black w-full">{`Delivery `}</p>
      <Frame3 />
    </div>
  );
}

function Group() {
  return (
    <div className="absolute h-[134px] left-[42px] top-[209px] w-[32px]">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 32 134">
        <g id="Group 1000009485">
          <line id="Line 77" stroke="var(--stroke-0, #8EC800)" strokeWidth="2" x1="17" x2="17" y1="27" y2="122" />
          <g id="Group 1000009484">
            <circle cx="16" cy="16" fill="var(--fill-0, #8EC800)" id="Ellipse 3488" r="16" />
            <g id="check">
              <path d={svgPaths.p1d439380} id="Vector" stroke="var(--stroke-0, white)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" />
            </g>
          </g>
          <circle cx="16" cy="122" fill="var(--fill-0, white)" id="Ellipse 3488_2" r="8.5" stroke="var(--stroke-0, #8EC800)" strokeWidth="7" />
        </g>
      </svg>
    </div>
  );
}

function ReviewContainer() {
  return (
    <div className="absolute contents left-[24px] top-[183px]" data-name="Review Container">
      <div className="absolute bg-white border border-[#f2f2f2] border-solid h-[429px] left-1/2 rounded-[12px] top-[183px] translate-x-[-50%] w-[382px]" data-name="Background Card" />
      <Frame1 />
      <Frame2 />
      <Group />
    </div>
  );
}

function ColorLight1() {
  return (
    <div className="h-[34px] relative shrink-0 w-[430px]" data-name="Color=Light">
      <div className="absolute bg-[#02021d] bottom-[8px] h-[5px] left-1/2 rounded-[100px] translate-x-[-50%] w-[134px]" data-name="Home Indicator" />
    </div>
  );
}

function IOsStatusBarHomeIndicator1() {
  return (
    <div className="absolute bottom-0 content-stretch flex flex-col items-start left-0 w-[430px]" data-name="iOS Status Bar & Home Indicator">
      <ColorLight1 />
    </div>
  );
}

function Button() {
  return (
    <div className="absolute bg-black content-stretch flex gap-[8px] h-[56px] items-center justify-center left-[24px] overflow-clip p-[12px] rounded-[99px] top-[842px] w-[382px]" data-name="Button">
      <p className="css-ew64yg font-['Inter:Medium',sans-serif] font-medium leading-[normal] not-italic relative shrink-0 text-[#f5f5f5] text-[18px]">Job delivered</p>
    </div>
  );
}

function Group1() {
  return (
    <div className="absolute bottom-0 contents left-0">
      <IOsStatusBarHomeIndicator1 />
      <Button />
    </div>
  );
}

function Message() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="Message">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="Message">
          <path d={svgPaths.p1e53b00} id="Vector" stroke="var(--stroke-0, #141B34)" strokeLinejoin="round" strokeWidth="1.5" />
          <path d={svgPaths.p2475d280} id="Vector_2" stroke="var(--stroke-0, #141B34)" strokeLinejoin="round" strokeWidth="1.5" />
        </g>
      </svg>
    </div>
  );
}

function Arrow1() {
  return (
    <div className="absolute bg-white content-stretch flex items-start left-[calc(75%+43.5px)] p-[8px] rounded-[14px] top-[74px]" data-name="Arrow">
      <div aria-hidden="true" className="absolute border border-[#dcdcdc] border-solid inset-0 pointer-events-none rounded-[14px]" />
      <Message />
    </div>
  );
}

export default function OrderHistory() {
  return (
    <div className="bg-[#f6f6f6] relative size-full" data-name="Order History">
      <StatusBarIPhone />
      <HeaderContainer />
      <IOsStatusBarHomeIndicator />
      <p className="absolute css-ew64yg font-['SF_Pro_Display:Medium',sans-serif] leading-[normal] left-[24px] not-italic text-[18px] text-black top-[138px]">Progress</p>
      <ReviewContainer />
      <Group1 />
      <Arrow1 />
    </div>
  );
}