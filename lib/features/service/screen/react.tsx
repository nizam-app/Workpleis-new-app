import svgPaths from "./svg-42crsoz4kr";
import imgEllipse2143 from "figma:asset/2cc2dfd63e2b731fe862865b89e2bd623e3e730a.png";
import imgReceivedAvatar from "figma:asset/01e7854b2613d19079ad4ee2d6dc78a8e74d16b5.png";

function ArrowLeftIcon() {
  return (
    <div className="relative size-[24px]" data-name="Arrow Left Icon">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="Arrow Left Icon">
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
    <div className="absolute content-stretch flex items-start left-[24px] p-[8px] rounded-[8px] top-[77px]" data-name="Arrow">
      <div aria-hidden="true" className="absolute border border-[#e0e0e0] border-solid inset-0 pointer-events-none rounded-[8px]" />
      <div className="flex items-center justify-center relative shrink-0">
        <div className="flex-none scale-y-[-100%]">
          <ArrowLeftIcon />
        </div>
      </div>
    </div>
  );
}

function MoreVertical() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="more-vertical">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="more-vertical">
          <path clipRule="evenodd" d={svgPaths.pa4b5800} fill="var(--fill-0, #111111)" fillRule="evenodd" id="Vector" />
          <path clipRule="evenodd" d={svgPaths.p3efafa00} fill="var(--fill-0, #111111)" fillRule="evenodd" id="Vector_2" />
          <path clipRule="evenodd" d={svgPaths.p2d30500} fill="var(--fill-0, #111111)" fillRule="evenodd" id="Vector_3" />
        </g>
      </svg>
    </div>
  );
}

function Arrow1() {
  return (
    <div className="absolute bg-white content-stretch flex items-start left-[calc(75%+43.5px)] p-[8px] rounded-[14px] top-[77px]" data-name="Arrow">
      <div aria-hidden="true" className="absolute border border-[#dcdcdc] border-solid inset-0 pointer-events-none rounded-[14px]" />
      <MoreVertical />
    </div>
  );
}

function ProfileDetails() {
  return (
    <div className="absolute content-stretch flex flex-col gap-[4px] items-start left-[calc(25%+34.5px)] not-italic top-[76px] w-[212px]" data-name="Profile Details">
      <p className="css-4hzbpn font-['SF_Pro_Display:Medium',sans-serif] leading-[normal] relative shrink-0 text-[20px] text-black w-full">Kazi Mahbub</p>
      <div className="flex flex-col font-['Poppins:Regular',sans-serif] justify-center leading-[0] relative shrink-0 text-[#696969] text-[12px] w-full">
        <p className="css-4hzbpn leading-[1.2]">Online</p>
      </div>
    </div>
  );
}

function ProfileHeader() {
  return (
    <div className="absolute contents left-[24px] top-[72px]" data-name="Profile Header">
      <Arrow />
      <Arrow1 />
      <div className="absolute left-[80px] size-[50px] top-[72px]">
        <img alt="" className="block max-w-none size-full" height="50" src={imgEllipse2143} width="50" />
      </div>
      <ProfileDetails />
    </div>
  );
}

function Paperclip() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="paperclip">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="paperclip">
          <path d={svgPaths.p18f8e800} id="Vector" stroke="var(--stroke-0, #756D6D)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" />
        </g>
      </svg>
    </div>
  );
}

function InputFieldDuplicate() {
  return (
    <div className="content-stretch flex gap-[31px] items-center relative shrink-0" data-name="Input Field Duplicate">
      <p className="css-4hzbpn font-['Plus_Jakarta_Sans:Regular',sans-serif] font-normal leading-[normal] relative shrink-0 text-[#a8a8a8] text-[16px] w-[230px]">Type here...</p>
      <Paperclip />
    </div>
  );
}

function InputFieldBackgroundDuplicate() {
  return (
    <div className="content-stretch flex items-center relative shrink-0" data-name="Input Field Background Duplicate">
      <InputFieldDuplicate />
    </div>
  );
}

function Search() {
  return (
    <div className="bg-[#f6f6f6] content-stretch flex h-[56px] items-center px-[16px] py-[12px] relative rounded-[16px] shrink-0 w-[310px]" data-name="Search">
      <InputFieldBackgroundDuplicate />
    </div>
  );
}

function SendButtonContainerDuplicate() {
  return (
    <div className="relative shrink-0 size-[56px]" data-name="Send Button Container Duplicate">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 56 56">
        <g id="Send Button Container Duplicate">
          <circle cx="28" cy="28" fill="var(--fill-0, black)" id="Ellipse 3487" r="28" />
          <g id="sent">
            <path d={svgPaths.p2ed34380} fill="var(--fill-0, #FDFDFD)" id="Vector" />
          </g>
        </g>
      </svg>
    </div>
  );
}

function InputFieldWrapperDuplicate() {
  return (
    <div className="absolute content-stretch flex gap-[16px] items-start left-[24px] top-[871px]" data-name="Input Field Wrapper Duplicate">
      <Search />
      <SendButtonContainerDuplicate />
    </div>
  );
}

function ColorLight() {
  return (
    <div className="h-[34px] relative shrink-0 w-[430px]" data-name="Color=Light">
      <div className="absolute bg-[#02021d] bottom-[8px] h-[5px] left-1/2 rounded-[100px] translate-x-[-50%] w-[134px]" data-name="Home Indicator" />
    </div>
  );
}

function IOsStatusBarHomeIndicator() {
  return (
    <div className="absolute bottom-0 content-stretch flex flex-col items-start left-0 w-[430px]" data-name="iOS Status Bar & Home Indicator">
      <ColorLight />
    </div>
  );
}

function InputContainerDuplicate() {
  return (
    <div className="absolute bottom-0 contents left-0" data-name="Input Container Duplicate">
      <div className="absolute bg-white border-[#ededed] border-solid border-t bottom-0 h-[110px] left-0 w-[430px]" data-name="Bottom Background Duplicate" />
      <InputFieldWrapperDuplicate />
      <IOsStatusBarHomeIndicator />
    </div>
  );
}

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
        <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 1.32804 4.07547">
          <path d={svgPaths.p193f1400} fill="var(--fill-0, black)" id="Cap" opacity="0.4" />
        </svg>
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
        <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 17.1417 12.3283">
          <path clipRule="evenodd" d={svgPaths.p18b35300} fill="var(--fill-0, black)" fillRule="evenodd" id="Wifi" />
        </svg>
      </div>
      <div className="absolute bottom-[33.77%] left-[calc(50%-30.26px)] top-[43.58%] translate-x-[-50%] w-[19.2px]" data-name="Cellular Connection">
        <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 19.2 12.2264">
          <path clipRule="evenodd" d={svgPaths.p1e09e400} fill="var(--fill-0, black)" fillRule="evenodd" id="Cellular Connection" />
        </svg>
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

function ReceivedAvatar() {
  return (
    <div className="relative rounded-[32px] shrink-0 size-[36px]" data-name="Received Avatar">
      <div aria-hidden="true" className="absolute inset-0 pointer-events-none rounded-[32px]">
        <div className="absolute bg-[#8ec800] inset-0 rounded-[32px]" />
        <div className="absolute inset-0 overflow-hidden rounded-[32px]">
          <img alt="" className="absolute h-[182.27%] left-[-86.43%] max-w-none top-[1.72%] w-[272.87%]" src={imgReceivedAvatar} />
        </div>
      </div>
    </div>
  );
}

function ReceivedMessageTextContainer() {
  return (
    <div className="bg-[#f4f5f6] flex-[1_0_0] min-h-px min-w-px relative rounded-[16px]" data-name="Received Message Text Container">
      <div className="flex flex-row items-center justify-center size-full">
        <div className="content-stretch flex items-center justify-center px-[24px] py-[16px] relative w-full">
          <p className="css-4hzbpn flex-[1_0_0] font-['Poppins:Regular',sans-serif] leading-[1.3] min-h-px min-w-px not-italic relative text-[#141416] text-[16px]">{`Of course, I'd be happy to help.`}</p>
        </div>
      </div>
    </div>
  );
}

function ReceivedMessageHeader() {
  return (
    <div className="content-stretch flex gap-[16px] items-start relative shrink-0 w-full" data-name="Received Message Header">
      <ReceivedAvatar />
      <ReceivedMessageTextContainer />
    </div>
  );
}

function ReceivedMessageContent() {
  return (
    <div className="content-stretch flex flex-col gap-[8px] items-end justify-center relative shrink-0 w-full" data-name="Received Message Content">
      <ReceivedMessageHeader />
      <p className="css-4hzbpn font-['Poppins:SemiBold',sans-serif] leading-[20px] not-italic relative shrink-0 text-[#dee0e2] text-[12px] w-[330px]">3.10 PM</p>
    </div>
  );
}

function ReplyHeader() {
  return (
    <div className="bg-[#caff45] relative rounded-[12px] shrink-0 w-full" data-name="Reply Header">
      <div className="flex flex-row items-center size-full">
        <div className="content-stretch flex items-center px-[24px] py-[12px] relative w-full">
          <div className="css-g0mm18 font-['Poppins:Regular',sans-serif] leading-[1.3] not-italic relative shrink-0 text-[#000080] text-[14px]">
            <p className="css-ew64yg mb-0">Here is link:</p>
            <p className="css-ew64yg mb-0">https://dribbble.com/borkatullah</p>
            <p className="css-ew64yg">https://flames/borkatullah/255</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function ReplyContainer() {
  return (
    <div className="content-stretch flex flex-col gap-[4px] items-end relative shrink-0 w-[311px]" data-name="Reply Container">
      <ReplyHeader />
      <p className="css-4hzbpn font-['Poppins:SemiBold',sans-serif] leading-[20px] not-italic relative shrink-0 text-[#dee0e2] text-[12px] text-right w-full">3.11 PM</p>
    </div>
  );
}

function Frame15() {
  return (
    <div className="content-stretch flex flex-col gap-[4px] items-end relative shrink-0 w-full">
      <ReceivedMessageContent />
      <ReplyContainer />
    </div>
  );
}

function UserAvatar() {
  return (
    <div className="relative rounded-[32px] shrink-0 size-[36px]" data-name="User Avatar">
      <div aria-hidden="true" className="absolute inset-0 pointer-events-none rounded-[32px]">
        <div className="absolute bg-[#8ec800] inset-0 rounded-[32px]" />
        <div className="absolute inset-0 overflow-hidden rounded-[32px]">
          <img alt="" className="absolute h-[182.27%] left-[-86.43%] max-w-none top-[1.72%] w-[272.87%]" src={imgReceivedAvatar} />
        </div>
      </div>
    </div>
  );
}

function Frame9() {
  return (
    <div className="col-1 content-stretch flex flex-col gap-[10px] items-start ml-[16px] mt-[16px] not-italic relative row-1 w-[251px]">
      <div className="flex flex-col font-['Poppins:Regular',sans-serif] justify-center leading-[0] relative shrink-0 text-[12px] text-[rgba(0,0,0,0.3)] w-full">
        <p className="css-4hzbpn leading-[1.2]">Describe offer</p>
      </div>
      <p className="css-4hzbpn font-['SF_Pro_Display:Medium',sans-serif] h-[42px] leading-[normal] overflow-hidden relative shrink-0 text-[14px] text-black text-ellipsis w-full">{`I have two tickets for the Al-Nassr  Paris match for sale design `}</p>
    </div>
  );
}

function Frame() {
  return (
    <div className="content-stretch flex items-center relative shrink-0">
      <p className="css-ew64yg font-['Inter:Regular',sans-serif] font-normal leading-[normal] not-italic relative shrink-0 text-[12px] text-[rgba(0,0,0,0.42)]">Price</p>
    </div>
  );
}

function Frame4() {
  return (
    <div className="content-stretch flex flex-col gap-[8px] items-start relative shrink-0 w-[68px]">
      <Frame />
      <p className="css-ew64yg font-['Inter:Semi_Bold',sans-serif] font-semibold leading-[normal] not-italic relative shrink-0 text-[14px] text-black">$ 1,300</p>
    </div>
  );
}

function Frame6() {
  return (
    <div className="bg-[#f8fbf1] content-stretch flex flex-col h-[65px] items-start justify-center px-[10px] py-[7px] relative rounded-[8px] shrink-0 w-[116px]">
      <div aria-hidden="true" className="absolute border border-[#e1e8d2] border-solid inset-0 pointer-events-none rounded-[8px]" />
      <Frame4 />
    </div>
  );
}

function Frame1() {
  return (
    <div className="content-stretch flex items-center relative shrink-0">
      <p className="css-ew64yg font-['Inter:Regular',sans-serif] font-normal leading-[normal] not-italic relative shrink-0 text-[12px] text-[rgba(0,0,0,0.42)]">Time</p>
    </div>
  );
}

function Frame5() {
  return (
    <div className="content-stretch flex flex-col gap-[8px] items-start relative shrink-0 w-[68px]">
      <Frame1 />
      <p className="css-ew64yg font-['Inter:Semi_Bold',sans-serif] font-semibold leading-[normal] not-italic relative shrink-0 text-[14px] text-black">5 Day</p>
    </div>
  );
}

function Frame7() {
  return (
    <div className="bg-[#f8fbf1] content-stretch flex flex-col h-[65px] items-start justify-center px-[10px] py-[7px] relative rounded-[8px] shrink-0 w-[116px]">
      <div aria-hidden="true" className="absolute border border-[#e1e8d2] border-solid inset-0 pointer-events-none rounded-[8px]" />
      <Frame5 />
    </div>
  );
}

function Frame10() {
  return (
    <div className="content-stretch flex items-center justify-between relative shrink-0 w-full">
      <Frame6 />
      <Frame7 />
    </div>
  );
}

function Frame11() {
  return (
    <div className="content-stretch flex flex-col gap-[26px] items-start relative shrink-0 w-full">
      <Frame10 />
      <div className="h-0 relative shrink-0 w-full">
        <div className="absolute inset-[-1px_0_0_0]">
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 251 1">
            <line id="Line 76" stroke="var(--stroke-0, #E0E0E0)" x2="251" y1="0.5" y2="0.5" />
          </svg>
        </div>
      </div>
    </div>
  );
}

function Frame2() {
  return (
    <div className="bg-[#e3e3e3] content-stretch flex h-[34px] items-center justify-center opacity-60 px-[10px] py-[6px] relative rounded-[66px] shrink-0 w-[110px]">
      <p className="css-ew64yg font-['SF_Pro_Display:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[14px] text-black">Vew Job</p>
    </div>
  );
}

function Frame3() {
  return (
    <div className="bg-black content-stretch flex h-[35px] items-center justify-center px-[10px] py-[6px] relative rounded-[66px] shrink-0 w-[110px]">
      <div aria-hidden="true" className="absolute border border-[rgba(0,0,0,0.3)] border-solid inset-0 pointer-events-none rounded-[66px]" />
      <p className="css-ew64yg font-['SF_Pro_Display:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[14px] text-white">Accept Offer</p>
    </div>
  );
}

function Frame8() {
  return (
    <div className="content-stretch flex gap-[31px] items-center relative shrink-0">
      <Frame2 />
      <Frame3 />
    </div>
  );
}

function Frame12() {
  return (
    <div className="col-1 content-stretch flex flex-col gap-[14px] items-start ml-[16px] mt-[99px] relative row-1 w-[251px]">
      <Frame11 />
      <Frame8 />
    </div>
  );
}

function Group() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <div className="bg-white border border-[#e1e8d2] border-solid col-1 h-[255px] ml-0 mt-0 rounded-[8px] row-1 w-[283px]" />
      <Frame9 />
      <Frame12 />
    </div>
  );
}

function Frame13() {
  return (
    <div className="content-stretch flex flex-col gap-[8px] items-start relative shrink-0 w-full">
      <UserAvatar />
      <Group />
      <p className="css-4hzbpn font-['Poppins:SemiBold',sans-serif] leading-[20px] min-w-full not-italic relative shrink-0 text-[#dee0e2] text-[12px] w-[min-content]">3.10 PM</p>
    </div>
  );
}

function AwaitHeader() {
  return (
    <div className="bg-[#caff45] content-stretch flex items-center justify-center px-[24px] py-[12px] relative rounded-[12px] shrink-0" data-name="Await Header">
      <p className="css-ew64yg font-['Poppins:Regular',sans-serif] leading-[1.3] not-italic relative shrink-0 text-[#000080] text-[14px]">Thank you kazi, I have accepted your offer</p>
    </div>
  );
}

function AwaitContainer() {
  return (
    <div className="content-stretch flex flex-col gap-[4px] items-end relative shrink-0" data-name="Await Container">
      <AwaitHeader />
      <p className="css-4hzbpn font-['Poppins:SemiBold',sans-serif] leading-[20px] min-w-full not-italic relative shrink-0 text-[#dee0e2] text-[12px] text-right w-[min-content]">3.11 PM</p>
    </div>
  );
}

function Frame14() {
  return (
    <div className="content-stretch flex flex-col gap-[4px] items-end relative shrink-0 w-full">
      <Frame13 />
      <AwaitContainer />
    </div>
  );
}

function Frame16() {
  return (
    <div className="absolute content-stretch flex flex-col gap-[12px] items-start left-[32px] top-[185px] w-[382px]">
      <Frame15 />
      <Frame14 />
    </div>
  );
}

export default function OneMessage() {
  return (
    <div className="bg-[#f6f6f6] relative size-full" data-name="One Message">
      <div className="absolute h-[137px] left-[calc(25%+20.5px)] top-[11px] w-[430px]">
        <div className="absolute inset-[-130.66%_-41.63%]">
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 788 495">
            <g filter="url(#filter0_f_1_264)" id="Ellipse 1148" opacity="0.5">
              <ellipse cx="394" cy="247.5" fill="var(--fill-0, #D8EBCB)" rx="215" ry="68.5" />
            </g>
            <defs>
              <filter colorInterpolationFilters="sRGB" filterUnits="userSpaceOnUse" height="495" id="filter0_f_1_264" width="788" x="0" y="0">
                <feFlood floodOpacity="0" result="BackgroundImageFix" />
                <feBlend in="SourceGraphic" in2="BackgroundImageFix" mode="normal" result="shape" />
                <feGaussianBlur result="effect1_foregroundBlur_1_264" stdDeviation="89.5" />
              </filter>
            </defs>
          </svg>
        </div>
      </div>
      <ProfileHeader />
      <p className="absolute css-4hzbpn font-['SF_Pro_Display:Bold',sans-serif] leading-[normal] left-1/2 not-italic text-[#23262f] text-[16px] text-center top-[146px] translate-x-[-50%] w-[382px]">Oct 17, 2022</p>
      <InputContainerDuplicate />
      <StatusBarIPhone />
      <Frame16 />
    </div>
  );
}