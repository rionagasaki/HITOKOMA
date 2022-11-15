import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import Stripe from "stripe";

admin.initializeApp();

const baseFunctions = functions.region("asia-northeast1");
const stripe = new Stripe(functions.config().stripe.apikey, {
  apiVersion: "2022-08-01",
});

// PayIntentの作成
exports.createPaymentIntents = baseFunctions.https.onCall(async (data)=> {
  const ephemeralKey = await stripe.ephemeralKeys.create(
      {customer: data.customerId},
      {apiVersion: "2022-08-01"},
  );
  const paymentIntent = await stripe.paymentIntents.create({
    amount: data.amount,
    currency: "jpy",
    customer: data.customerId,
    automatic_payment_methods: {
      enabled: true,
    },
  });
  return {
    paymentIntent: paymentIntent.client_secret,
    ephemeralKey: ephemeralKey.secret,
    customer: data.customerId,
    // eslint-disable-next-line max-len
    publishableKey: "pk_test_51LvcnMIMOIL9adjNYRI6Tr2V1KOmdpf1l2xpG5dlSyo6Ek146iRPhwgVmNDwYmDhmtAV785Lc5qe2s9gTkxMO7Oc00UVvNaqQF",
  };
});

// Customerの作成
exports.createCustomer = baseFunctions.https.onCall(async (user) => {
  const email = user.email;
  const customer = await stripe.customers.create(
      {email: email});
  return {customerId: customer.id};
});

// 決済の作成(Separate Charges and Transfers)
exports.createCharege = baseFunctions.https.onCall(async (data) =>{
  const customer = data.customerId;
  const amount = data.amount;
  return stripe.charges.create(
      {
        customer: customer,
        amount: amount,
        currency: "jpy",
      },
      {
        idempotencyKey: data.idempotencyKey,
      }
  );
});

exports.createTransfer = baseFunctions.https.onCall(async (data) => {
  // 送金元の決済ID
  const chargeId = data.charge.id;
  const amount = data.charge.amount;
  const feeAmount = Math.floor((amount * 1) / 4);
  const transferAmount = amount - feeAmount;
  const targetAccountIds = data.targetAccountIds;
  const singleAmount = Math.floor(transferAmount / targetAccountIds.length);
  for (const accountId of targetAccountIds) {
    await stripe.transfers.create(
        {
          amount: singleAmount,
          currency: "jpy",
          destination: accountId,
          source_transaction: chargeId,
        },
        {
          idempotencyKey: data.idempotencyKey,
        }
    );
  }
});

exports.createCheckout = functions.https.onCall(async () => {
  try {
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      mode: "payment",
      success_url: "http://localhost:5500/success",
      cancel_url: "http://localhost:5500/cancel",
      line_items: [
        {
          quantity: 1,
          price_data: {
            currency: "usd",
            unit_amount: (100) * 100,
            product_data: {
              name: "New camera",
            },
          },
        },
      ],
    });
    return {
      id: session.id,
    };
  } catch (err) {
    console.log(err);
    return {status: err};
  }
});

exports.createAccountLink = functions.https.onCall(async () => {
  try {
    const account = await stripe.accounts.create({
      country: "JP",
      type: "express",
      capabilities: {
        card_payments: {requested: true},
        transfers: {requested: true}},
      business_type: "individual",
      business_profile: {product_description: ""},
    });
    const accountLink = await stripe.accountLinks.create({
      account: account.id,
      refresh_url: "https://example.com/",
      return_url: "https://example.com/",
      type: "account_onboarding",
    });
    return {accountLink: accountLink.url};
  } catch (error) {
    return {error: error};
  }
});

exports.createDashboardLink = functions.https.onCall(async () => {
  try {
    const link = await stripe.accounts.createLoginLink("acct_1LzUgORNjq7ggqM9");
    return {
      object: link.object,
      created: link.created,
      url: link.url,
    };
  } catch (error) {
    return {error: error};
  }
});
