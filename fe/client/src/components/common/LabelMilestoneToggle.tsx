import styled from "styled-components";
import LabelIcon from '@/Icons/Label.svg';
import MilestoneIcon from '@/Icons/Milestone.svg';

const LabelMilestoneToggle = () => {
  return (
    <ToggleWrapper>
      <ToggleItem>
        <RadioButton type="radio" name="labelMilestone" />
        <LabelBelongSpan> <img src={LabelIcon} alt="" /> &nbsp; 레이블 </LabelBelongSpan>
      </ToggleItem>
      <ToggleItem>
        <RadioButton type="radio" name="labelMilestone" />
        <LabelBelongSpan>  <img src={MilestoneIcon} alt="" /> &nbsp; 마일스톤</LabelBelongSpan>
      </ToggleItem>
    </ToggleWrapper>
  );
};

const ToggleWrapper = styled.div`
  display: flex;
  width: 320px;
  height: 40px;
  font-weight: 700;
  color: #6e7191;
`;

const ToggleItem = styled.label`
  width: 160px;
  height: 100%;
  text-align: center;
  
  &:hover > span {
    background: #eff0f6;
  }
  :first-child > span {
    border-radius: 11px 0 0 11px;
    border: 1px solid #d9dbe9;
  }
  :last-child > span {
    border-radius: 0 11px 11px 0;
    border: 1px solid #d9dbe9;
    border-left:0;
  }
`;

const RadioButton = styled.input`
  display: none;
  &:checked + span {
    background: #d9dbe9;
  }
`;

const LabelBelongSpan = styled.span`
  height: 100%;
  width: 100%;
  background: #f5f5f7;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  box-shadow:0px 1px 1px -1px rgb(0 0 0 / 20%), 0px 1px 1px 0px rgb(0 0 0 / 14%), 0px 1px 5px 0px rgb(0 0 0 / 12%);
  &:hover {
    cursor: pointer;
  }
`;

export default LabelMilestoneToggle;
