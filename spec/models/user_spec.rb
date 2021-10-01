require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'name,email,password,password_confirmationが存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
    end
    
    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("なまえを入力してください")
      end
      
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      
      it 'emailに@が含まれていない場合登録できない' do
        @user.email = 'hoge.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      
      it 'passwordが6文字未満では登録できない' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（かくにんよう）とパスワードの入力が一致しません')
      end
      
      it 'passwordが英字のみの場合登録できない' do
        @user.password = 'abcdef'
        binding.pry
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは はんかくえいすうじを それぞれ１しゅるいいじょうふくむ 6もじいじょうで にゅうりょくしてください')
      end
      
      it 'passwordが数字のみの場合登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは はんかくえいすうじを それぞれ１しゅるいいじょうふくむ 6もじいじょうで にゅうりょくしてください')
      end
      
      it 'passwordは、全角文字を含むと登録できない' do
        @user.password = '１23abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは はんかくえいすうじを それぞれ１しゅるいいじょうふくむ 6もじいじょうで にゅうりょくしてください')
      end
      
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（かくにんよう）とパスワードの入力が一致しません")
      end
      
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '1234abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（かくにんよう）とパスワードの入力が一致しません")
      end
    end
  end
end