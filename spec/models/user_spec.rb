require File.dirname(__FILE__) + '/../spec_helper'

describe User do
    before(:each) do
        User.find(:all).each { |u| u.destroy_for_real }
        @user = User.new
    end
    
    describe "aware of whether its logged in" do
        before(:each) do
            @user = Factory.build( :user )
        end
        
        it "should not be logged in" do
            @user.should_not be_logged_in
        end
    
        describe "once saved" do
            before(:each) do
                @user.save!
            end
        
            it "should be logged in" do
                @user.should be_logged_in
            end
        
            it "but then be turned off (i.e. not logged in)" do
                @user.log_out
                @user.should_not be_logged_in
            end
        end
    end


    describe "enforcing unique email" do
        before(:each) do
            @user = Factory.create(:user)
        end
        
        it do
            @user.should be_valid
        end
        
        describe "a second user with same address" do
            before(:each) do
                @user2 = User.new( @user.attributes )
            end
            
            it "should not be valid" do
                @user2.should_not be_valid
            end
            
            it "should already be in the system" do
                @user2.save
                @user2.already_exists?.should be_true
            end
        end
    end

    describe "creating in bulk" do
        describe "from names prefixed and mixed with plain emails" do
            def addr
                %Q{arunj@velot.com, ms1874@columbia.edu, "Eyles, Julian" <julian.eyles@credit-suisse.com>, "Gene Palma" <ecpalma@gmail.com>, "Morris Barrett" <barrettrm@earthlink.net>, "Paul Balmer" <balmer@mac.com>, "Ravi Ramachandran" <ravi.ramachandran@scandent.com>, "Rob Houtenbous" <rob.houtenbos@verizon.net>, "Scruton, Andrew" <andrew.scruton@fticonsulting.com>, "Shakeel Hameed" <shakeel@electusgroup.com>, ron_torok@ml.com, DSTEERE@audubon.org, Robert.Carlson@barclayscapital.com, luis.a.galeano@jpmorgan.com, joshsquash@nyc.com, pjanowit@yahoo.com, jhirshey@hotmail.com, wcgconsult@hotmail.com, hevans@lehman.com, rimon@nyc.rr.com, chenner23@yahoo.com, george.boudouris@csfb.com, reinach@earthlink.net, vasthana@deloitte.com}
            end

            it "should return 24 users" do
                User.bulk_build( addr ).size.should eql(24)
            end
            
            it "should build 20 users" do
                User.bulk_build( addr )[0].should be_a_kind_of( User )
            end
            
            it "should create! 24 users" do
                User.bulk_create!( addr )
                User.count.should eql( 24 )
            end
        end

        describe "with names prefixed" do
            it "should create xxxx users" do
                User.bulk_create!( 
                    %Q{arunj@velot.com, ms1874@columbia.edu, "Eyles, Julian" <julian.eyles@credit-suisse.com>, "Gene Palma" <ecpalma@gmail.com>, "Morris Barrett" <barrettrm@earthlink.net>, "Paul Balmer" <balmer@mac.com>, "Ravi Ramachandran" <ravi.ramachandran@scandent.com>, "Rob Houtenbous" <rob.houtenbos@verizon.net>, "Scruton, Andrew" <andrew.scruton@fticonsulting.com>, "Shakeel Hameed" <shakeel@electusgroup.com>, ron_torok@ml.com, DSTEERE@audubon.org, Robert.Carlson@barclayscapital.com, luis.a.galeano@jpmorgan.com, joshsquash@nyc.com, pjanowit@yahoo.com, jhirshey@hotmail.com, wcgconsult@hotmail.com, hevans@lehman.com, rimon@nyc.rr.com, chenner23@yahoo.com, george.boudouris@csfb.com, reinach@earthlink.net, vasthana@deloitte.com}
                )
                User.count.should eql( 24 )
            end
        
            it "create 117 friends" do
                addrs = <<EOS
"Ben Collier" <bencollier@gmail.com>,
"Chris Kao" <chris.chriskao@gmail.com>,
"Daniel M. Silvershein" <dmsilver@verizon.net>,
"Dhiraj Bhagat" <dsb114@columbia.edu>,
"Elys Roberts" <elys.roberts@medefield.com>,
"Eric Gertler" <ericgertler@yahoo.com>,
"Eric Gorman" <eric@turtell.com>,
"Eyles, Julian" <julian.eyles@credit-suisse.com>,
"Gene Palma" <ecpalma@gmail.com>,
"Morris Barrett" <barrettrm@earthlink.net>,
"Paul Balmer" <balmer@mac.com>,
"Ravi Ramachandran" <ravi.ramachandran@scandent.com>,
"Rob Houtenbous" <rob.houtenbos@verizon.net>,
"Scruton, Andrew" <andrew.scruton@fticonsulting.com>,
"Shakeel Hameed" <shakeel@electusgroup.com>,
"Stefan Zoltowski" <stefan.zoltowski@iris-ny.com>,
"Taru Goel" <tarugoel@yahoo.com>,
ron_torok@ml.com,
DSTEERE@audubon.org,
Robert.Carlson@barclayscapital.com,
luis.a.galeano@jpmorgan.com,
joshsquash@nyc.com,
pjanowit@yahoo.com,
jhirshey@hotmail.com,
wcgconsult@hotmail.com,
hevans@lehman.com,
rimon@nyc.rr.com,
chenner23@yahoo.com,
george.boudouris@csfb.com,
reinach@earthlink.net,
vasthana@deloitte.com,
arunj@velot.com,
ms1874@columbia.edu,
grantinnyc@yahoo.com,
reso_pana@hotmail.com,
steventyoung@hotmail.com,
danieljacobsen@gmail.com,
varunbedi@gmail.com,
mwiertz@lincolncenter.org,
DavidsonRB@bernstein.com,
mkrjf@yahoo.com,
Tamer.Seoud@use.salvationarmy.org,
mhaldema@wso.williams.edu,
epstein_david@hotmail.com,
esteban.chiappe@jpmorgan.com,
JayW@warshawgroup.com,
ml@acosfm.com,
PWithstandley@flhlaw.com,
rweisberg@pppdocs.com,
Andrew.Bogle@morganstanley.com,
C.Sackman@sackman.com,
pcmfeist@hotmail.com,
crc@campaigne.com,
shahzad.hasan@jpmchase.com,
borismh@nysbar.com,
RGoo9563@aol.com,
moran08@earthlink.net,
utech@discerror.com,
wuricha@gmail.com,
lzhang2@nd.edu,
webbmart@shu.edu,
ORM@tmo.blackberry.net,
lianne@emg-ltd.com,
kamal.d.pallan@jpmchase.com,
Paulash.Mohsen@pfizer.com,
walid.albeltagy@db.com,
mauro.conijeski@us.hsbc.com,
rpejan@yahoo.com,
walter.kramer@citigroup.com,
hoyoonnam@gmail.com,
carlos.galindo@db.com,
Peter.Davidson@morganstanley.com,
rafi@ptsolutions.com,
ned.hole@gmail.com,
david@schradschoen.com,
sumeet122@gmail.com,
brettaerasmus@yahoo.com,
tkearney8@nyc.rr.com, reiss@law.fordham.edu, Lauri.Sklar@aig.com, sorren@us.ibm.com, Sanjay@archeuscap.com, SFruchtm@tttus.jnj.com, jenniferageorge@gmail.com, garykaplan@hotmail.com, rbrinkman@clickwinegroup.com, o.bynke@peerlessimporters.com, david.c.prince@verizon.net, nichard1@mac.com, ppotocki@yahoo.com, venky@sci.ccny.cuny.edu, ananda@citigroup.com, dcheslop2@aol.com, jford@mreem.com, francois@mouawad.com, andrewabogle@gmail.com, sunc175@hotmail.com, bunts@nyu.edu, Aamer.Naseer@lehman.com, amjadp@ccrny.com, elizabeth.shields@db.com, etiedeken2002@yahoo.com, spall5@hotmail.com, buntsz@gmail.com, Joe@screenstyle.com, ethan_ram@yahoo.com, chrisgerra@msn.com, fosb@aol.com, Chris.George@thomson.com, kajanant@gmail.com, stevew@warshawgroup.com, sburnazian@avenuecapital.com, Chasecarly@aol.com, DPorter@dghm.com, webbmart@nyc.rr.com, rkaskel@xtg.bz, jeffrey.schumacher@lehman.com, corywarfield@gmail.com, gdavis@athena-ny.com, tarun@indigohome.us, lars@population2.com, AHunt@despont.com, michael.cashman@db.com, Christopher.e.George@thomson.com, Jim.Lynch@satlynx.com, raubry@gmail.com, Michael.Beaton@macquarie.com, Michael.Droege@dkib.com, hsidel@jotosake.com, rodrigo.botti@citigroup.com, santilynch@hotmail.com, cvnguyen@gmail.com, MCASSIDY@corcoran.com, mhenderson@isigrp.com, carl.yang@americas.bnpparibas.com, maximojulian@hotmail.com, gharder1@nyc.rr.com, marcpgold@gmail.com, aelhendy@aim.com, rob.simik@gmail.com, cstuard@thirdpillar.com, jbrisman@chpnet.org, mconijeski@gmail.com, kristian.horvei@gmail.com, russelld@panix.com, phil_green@bd.com, julzdonald@aol.com, mauro.conijeski@lehman.com, Asif_Ali@platts.com, Zubair.Khan@ubs.com, don.hanna@citi.com, Jimboxox@aol.com, antonio.garcia-martinez@gs.com, jason.kushner@lehman.com, jlaux@sidoti.com, rghosh@math.utexas.edu, Adrian.A.Zackheim@williams.edu, Peter.C.Munsill@pjc.com, jmm268@cornell.edu, Nicholas.Apostolatos@morganstanley.com, rpcorwin@rpcorwin.com, sourav.kar@lehman.com, shareef.mostafa@gmail.com, james.zhang@alumni.nd.edu, ashleighpattee@gmail.com, henri.de-saint-mars@sgcib.com, alexandergreen22@gmail.com, Reesor@vzw.blackberry.net, Michael.Avallone@gfigroup.com, kareem.idrees@gmail.com, michael.p.mcconnell@gmail.com, neilhorner@gmail.com, francisco.seitun@db.com, daryl.arnold@profero.com, hsebring@gmail.com, callahan.greg@gmail.com, chirigos@aol.com, Agustin.Collazo@morganstanley.com, JPerez@bhsusa.com, OstrowJ@witkoff.com, curtiscampaigne@gmail.com, Gerry.Atkinson@frmhedge.com, malonejenny@yahoo.co.uk, MPlante@enernoc.com, Shahzad_Hasan@ml.com, powerplayer_2025@yahoo.com, fperrin48@hotmail.com, jzeide@fountainfinancial.com, ahmed.x.badami@jpmchase.com, Josh.kroo@gmail.com, Ira_Veridiano@spotcable.com, matt@sekorpartners.com, hayya_fayaz@yahoo.com, Alexandra.Nortier@morganstanley.com, faisal.asghar@citi.com, Julieanne_herskowitz@akrf.com, brett.erasmus@db.com, jonathan.regenstein@gmail.com, jeffrey.angard@americas.bnpparibas.com, doug.root@invesco.com, geoboudouris@hotmail.com, blaircranston@hotmail.com, JGreen@giantrealm.com, aviralrai@aol.com, manish.pahlajani@db.com, silis.andris@gmail.com, ouaknine@hotmail.com, ejs@rcn.com, salvador.madrigal@gmail.com, Brian.Rassel@ubs.com, pahaynes@lehman.com, HWISELAW@aol.com, atilney@gmail.com, chesterchall@gmail.com, cemp51d@gmail.com, bpeelle@hotmail.com, christophe@danhier.us, ccklancaster@gmail.com, jody.t.feldman@bob.hsbc.com, sluggo1138@mac.com, katherine.e.hoy@us.pwc.com, obell@google.com, aleem@google.com, morris@tisserie.com, ariel.grignafini@db.com, daniel.crespo85@gmail.com, jeremyw9@hotmail.com, gdavis@bfdrealestate.com, haynes.gallagher@citi.com, rukhein.davis@gmail.com, jhahn@asiaalpha.com, danielramot@gmail.com, ychaxel@gmail.com, rhemm@cov.com, caribman55@yahoo.com, KBetz@yodle.com, jweldon@garrisoninv.com, particular@gmail.com, david@baxter.net.au, franckpierson@gmail.com, gavin@touchnewyorkcity.com, foxlrf@yahoo.com, softtargets@gmail.com, fostr24@yahoo.com, sbyrod@mac.com, davidalansegal@gmail.com, bennett.kolasinski@gmail.com, Kevin.Sharma@mba09.mccombs.utexas.edu, topher330@gmail.com, marktomokorubery@yahoo.co.uk, carter@aninternetstartup.com, ken_ming_wu@hotmail.com, p.holden@ymail.com, talerman@gmail.com, luca.salvato@collercapital.com, kj49@cornell.edu, Daniel.Varga@morganstanley.com, Bentley.Weiner@hbo.com, peterberry@acedsl.com, marclevinnyc1@yahoo.com, GottemakerA@pcaobus.org, kishore.vasnani@thomsonreuters.com, Tomas.Puverle@morganstanley.com, jmccarthy86@gmail.com, Hugh@th-advisors.com, matt.huntington@gmail.com, craig_hutchison@hotmail.com, julieanne.herskowitz@gmail.com, conhatzis@hotmail.com, peter.kreisler@glgpartners.com, Greg.Bryan@legion.com, katerman@gmail.com, 10tre@williams.edu, christinacranematthias@gmail.com, jason.beren@db.com, vnatarajan@polarismanagement.com, shakticganti@gmail.com
EOS
                User.bulk_create!( addrs )
                User.count.should eql(277)
            end

            it "create 17 friends" do
                addrs =<<EOS
    "Ben Collier" <bencollier@gmail.com>, "Chris Kao" <chris.chriskao@gmail.com>, "Daniel M. Silvershein" <dmsilver@verizon.net>, "Dhiraj Bhagat" <dsb114@columbia.edu>, "Elys Roberts" <elys.roberts@medefield.com>, "Eric Gertler" <ericgertler@yahoo.com>, "Eric Gorman" <eric@turtell.com>, "Eyles, Julian" <julian.eyles@credit-suisse.com>, "Gene Palma" <ecpalma@gmail.com>, "Morris Barrett" <barrettrm@earthlink.net>, "Paul Balmer" <balmer@mac.com>, "Ravi Ramachandran" <ravi.ramachandran@scandent.com>, "Rob Houtenbous" <rob.houtenbos@verizon.net>, "Scruton, Andrew" <andrew.scruton@fticonsulting.com>, "Shakeel Hameed" <shakeel@electusgroup.com>, "Stefan Zoltowski" <stefan.zoltowski@iris-ny.com>, "Taru Goel" <tarugoel@yahoo.com>,
EOS
                User.bulk_create!( addrs )
                User.count.should eql(17)
            end
        end
    end

    describe "bulk creating, then bulk updating" do
        before(:each) do
            @users = User.bulk_create!( %Q{arunj@velot.com, ms1874@columbia.edu, "Eyles, Julian" <julian.eyles@credit-suisse.com>} )
        end

        it "should create! 3 users" do
            User.count.should eql( 3 )
        end

        it "should return 3 users" do
            @users.size.should eql( 3 )
        end
    end
    
    describe "adding in bulk (via friends)" do
        describe "when adding with '\"Chris Kao\" <chris.chriskao@gmail.com>'" do
            before do
                @user = User.new_from_bulk_create( '"Chris Kao" <chris.chriskao@gmail.com>' )
            end

            it "set the user's first name" do
                @user.first_name.should eql('Chris')
            end

            it "set the user's last name" do
                @user.last_name.should eql('Kao')
            end

            it "set the user's email" do
                @user.email.should eql('chris.chriskao@gmail.com')
            end
        end

        describe "when adding with '\"Gene de Palma\" <ecpalma@gmail.com>'" do
            before do
                @user = User.new_from_bulk_create( '"Gene de Palma" <ecpalma@gmail.com>' )
            end

            it "set the user's first name" do
                @user.first_name.should eql('Gene')
            end

            it "set the user's last name" do
                @user.last_name.should eql('de Palma')
            end

            it "set the user's email" do
                @user.email.should eql('ecpalma@gmail.com')
            end

            it "should be valid" do
                @user.should be_valid
            end
        end

        describe "when adding with '<ecpalma@gmail.com>'" do
            before do
                @user = User.new_from_bulk_create( '<ecpalma@gmail.com>' )
            end

            it "not set the user's first name" do
                @user.first_name.should be_blank
            end

            it "not set the user's last name" do
                @user.last_name.should be_blank
            end

            it "set the user's email" do
                @user.email.should eql('ecpalma@gmail.com')
            end

            it "should be valid" do
                @user.should be_valid
            end
        end

        describe "when adding with '\"Eyles, Julian\" <julian.eyles@credit-suisse.com>'" do
            before do
                @user = User.new_from_bulk_create( '"Eyles, Julian" <julian.eyles@credit-suisse.com>' )
            end

            it "set the user's first name" do
                @user.first_name.should eql( "Julian" )
            end

            it "set the user's last name" do
                @user.last_name.should eql("Eyles")
            end

            it "set the user's email" do
                @user.email.should eql('julian.eyles@credit-suisse.com')
            end

            it "should be valid" do
                @user.should be_valid
            end
        end
    end

    describe "with only an email" do
        before(:each) do
            @user = User.new
        end

        it "should not be valid with just an email" do
            @user.email = "someone@somedomain.com"
            @user.should_not be_valid
        end

    end

    describe "searching" do
        it "should search by first name" do
            User.filtered_by( :first_name => 'jose' ).proxy_options.should eql( {:conditions=>["LOWER( first_name ) LIKE ?", "jose%"]} )
        end

        it "should ignore empty attributes" do
            User.filtered_by( :first_name => 'jose', :last_name => '' ).proxy_options.should eql( {:conditions=>["LOWER( first_name ) LIKE ?", "jose%"]} )
        end

        it "should strip space" do
            User.filtered_by( :first_name => '  jose', :last_name => '' ).proxy_options.should eql( {:conditions=>["LOWER( first_name ) LIKE ?", "jose%"]} )
        end

        describe "filtering by rating" do
            it "should accept exact matches" do
                User.filtered_by( :first_name => '  jose', :rating_from => '5.11', :rating_to => '5.11' ).proxy_options.should eql( {:conditions=>["LOWER( first_name ) LIKE ?", "jose%" ]} )
            end

            it "should accept greater than matches" do
                User.filtered_by( :first_name => '  jose', :rating_from => '5.11', :rating_to => '6' ).proxy_options.should eql( {:conditions=>["LOWER( first_name ) LIKE ?", "jose%" ]} )
            end

            it "should accept only a starting from rating" do
                User.filtered_by( :first_name => '  jose', :is_root => 'true' ).proxy_options.should eql( {:conditions=>["LOWER( first_name ) LIKE ?", "jose%"]} )
            end
        end
    end
end








# == Schema Information
#
# Table name: users
#
#  id                        :integer         not null, primary key
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  name                      :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  last_logged_in_at         :datetime
#  anonymous_login_code      :string(255)
#  location                  :string(255)
#  gender                    :string(255)
#  city                      :string(255)
#  country                   :string(255)
#  state_abbrev              :string(255)
#  is_admin                  :boolean         default(FALSE)
#  is_root                   :boolean         default(FALSE)
#  handed                    :string(255)
#  is_deleted                :boolean         default(FALSE)
#  first_name                :string(255)
#  last_name                 :string(255)
#  show_age                  :boolean         default(FALSE)
#  mugshot_file_size         :integer
#  mugshot_file_name         :string(255)
#  mugshot_content_type      :string(255)
#  rating_by_self            :integer
#  effective_rating          :integer
#  rating_by_pro             :integer
#  has_memberships           :boolean         default(FALSE)
#  is_pro                    :boolean         default(FALSE)
#  user_sort                 :string(255)
#  phone                     :string(255)
#

